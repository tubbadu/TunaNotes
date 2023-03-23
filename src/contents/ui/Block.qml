import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser

RowLayout{
	id: block
	//width: parent.width
	spacing: 0

	enum Type{
		Header,
		Quote,
		DotList,
		CheckList,
		PlainText,
		CodeBlock
	}
	property int type//: getType()
	property alias text: txt.text
	property string setText: "*error*" // used to set an initial value
	property int tabNum: 0
	property bool checked: false
	property int headerNum: 0
	property var parseResult: Parser.parseMarkdownLine(setText)
	property bool isActiveItem: (document.currentIndex === index)

	function getType(){
		text = parseResult.plainText
		if(parseResult.isChecklist){
			type = Block.Type.CheckList
			checked = parseResult.isChecked
			//console.warn("type: checklist")
			return
		} else if(parseResult.isDotList){
			type = Block.Type.DotList
			//console.warn("type: dotlist")
			return
		} else if(parseResult.isQuote){
			type = Block.Type.Quote
			//console.warn("type: quote")
			return
		} else if(parseResult.isCodeBlock){
			type = Block.Type.CodeBlock
			//console.warn("type: codeblock")
			return
		} else if(parseResult.isHeader){
			type = Block.Type.Header
			headerNum = parseResult.headerNumber
			//console.warn("type: header")
			return
		}

		type = Block.Type.PlainText
	}

	function newBlock(){
		blockModel.insert(index+1, {set_text: ""}) // TODO set type
		down()
	}

	function setCursorPosition(pos){
		if(pos === -1){
			txt.cursorPosition = txt.length
		} else if (pos < txt.length){
			txt.cursorPosition = pos
		} else {
			txt.cursorPosition = txt.length
		}
	}

	function forceFocus(){
		txt.forceActiveFocus()
		setCursorPosition(-1)
		console.warn("forced focus on active object")
	}

	function up(){
		if(index > 0){
			document.currentIndex = index-1
			document.currentItem.setCursorPosition(calculateNextCursorPosition())
		}
	}

	function down(){
		if(index + 1 < listView.count){
			document.currentIndex = index + 1
			document.currentItem.setCursorPosition(calculateNextCursorPosition())
		}
	}

	function calculateNextCursorPosition(){
		let cursor_index = txt.cursorPosition
		console.warn(txt.cursorPosition)
		if(txt.cursorPosition == txt.length){
			cursor_index = -1
		} else if(txt.cursorPosition == 0){
			cursor_index = 0
		}
		return cursor_index
	}

	Component.onCompleted:{
		getType()
	}

	
	IndentElement{
		tabSize: checkboxelement.width
		tabNum: block.tabNum
	}
	CheckBoxElement{
		id: checkboxelement // I'll use this element's width as referiment, because it's the largest
	}
	DotListElement{
		width: checkboxelement.width
	}
	QuoteElement{
		width: checkboxelement.width
	}
	
	TextEdit{
		id: txt
		property int lineHeight: height / lineCount
		Layout.fillWidth: true
		Layout.alignment: Qt.AlignTop
		Layout.topMargin: 2
		Layout.leftMargin: 3
		font.pixelSize: 15
		text: "ciao"
		color: "#fcfcfc"
		tabStopDistance: checkboxelement.width
		textFormat: block.Type === Block.Type.CodeBlock ? TextEdit.PlainText : TextEdit.MarkdownText

		Keys.onPressed: (event) => {
			if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
				console.warn("enter");
				event.accepted = true;
				newBlock();
			} else if (event.key == Qt.Key_Down) {
				console.warn("down");
				event.accepted = true;
				down();
			} else if (event.key == Qt.Key_Up) {
				console.warn("up");
				event.accepted = true;
				up();
			}
		}

		onFocusChanged: {
			// needed to set the current item on the clicked element
			if(focus && (document.currentIndex !== index)){
				document.currentIndex = index
			}
		}

	}

	onFocusChanged: {
		// needed to set text focus when selecting block with arrows
		if(focus && !txt.focus){
			txt.focus = true
		}
	}
}