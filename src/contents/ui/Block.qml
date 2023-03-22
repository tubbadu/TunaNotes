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
		blockModel.insert(index+1, {set_text: "new block!!!!"}) // TODO set type
	}

	function up(){
		if(index > 0){
			document.currentIndex = index-1
		}
	}

	function down(){
		if(index + 1 < listView.count){
			document.currentIndex = index + 1
		}
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
		focus: true
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
			if(focus)
				document.currentIndex = index
		}
	}

	onFocusChanged: {
		if(focus)
			txt.focus = true
	}
}