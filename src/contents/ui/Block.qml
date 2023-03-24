import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser
import "keyHandler.js" as KeyHandler

RowLayout{
	id: block
	width: parent.width
	spacing: 0

	enum Type{
		PlainText,
		//Header, // remove
		Quote,
		DotList,
		CheckList,
		CodeBlock
	}
	property int type: Block.Type.PlainText
	property alias text: txt.text
	property string setText: "*error*" // used to set an initial value
	property int setType: -1
	property int tabNum: 0
	property bool checked: false
	property bool enableTextFormat: true
	property int headerNum: 0
	property var parseResult: Parser.parseMarkdownLine(setText)
	property alias cursorPosition: txt.cursorPosition
	property alias length: txt.length

	function getType(t = setText){
		parseResult =  Parser.parseMarkdownLine(t)
		text = parseResult.plainText
		//console.warn(text + "!!!")
		if(parseResult.isChecklist){
			type = Block.Type.CheckList
			checked = parseResult.isChecked
			return
		} else if(parseResult.isDotList){
			type = Block.Type.DotList
			return
		} else if(parseResult.isQuote){
			type = Block.Type.Quote
			return
		} else if(parseResult.isCodeBlock){
			type = Block.Type.CodeBlock
			return
		} else if(parseResult.isHeader){
			headerNum = parseResult.headerNumber
			return
		}

		type = Block.Type.PlainText;
	}

	function newBlock(set_text=""){
		blockModel.insert(index+1, {set_text: set_text, set_type: newType()}) // TODO set type
		down()
	}

	function newType(){
		if (type == Block.Type.CheckList || type == Block.Type.DotList || type == Block.Type.Quote){
			// copy formatting
			return type
		} else {
			// use PlainText
			return Block.Type.PlainText
		}
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

	function mergeBlocks(i1, i2){ // b1 is removed and attached to b2 (i is the index)
		let extext = listView.itemAtIndex(i2).text.replace(/\n\n$/g, "") // TODO remove problem at the source (parser probably) (no, probably it's more difficult)
		let pos = listView.itemAtIndex(i2).length
		listView.itemAtIndex(i2).text = extext + listView.itemAtIndex(i1).text.replace(/\n\n$/g, "")
		listView.itemAtIndex(i2).forceFocus()
		listView.itemAtIndex(i2).setCursorPosition(pos)
		
		document.remove(i1)
	}

	function textSize(){
		let x = [34, 26, 23, 20, 18, 17]
		let n = headerNum - 1
		if(n < 0){
			return 15
		}

		let ret = x[n]
		if(ret == undefined){
			return x[x.length-1]
		}

		return ret
	}

	Component.onCompleted:{
		if(setType == -1){
			console.warn("no type specified, calculate type")
			getType()
		} else {
			text = parseResult.plainText
			block.type = block.setType
		}
		
	}

	IndentElement{
		id: indentelement
		tabSize: checkboxelement.width
		tabNum: block.tabNum
	}
	CheckBoxElement{
		id: checkboxelement // I'll use this element's width as referiment, because it's the largest
		Layout.maximumHeight: txt.lineHeight
	}
	DotListElement{
		width: checkboxelement.width
		Layout.maximumHeight: txt.lineHeight
	}
	QuoteElement{
		width: checkboxelement.width
		Layout.maximumHeight: txt.lineHeight
	}
	
	TextEdit{
		id: txt
		property int lineHeight: height / lineCount
		Layout.fillWidth: true
		Layout.alignment: Qt.AlignTop
		Layout.topMargin: 2
		Layout.leftMargin: 3
		font.pixelSize: textSize()
		font.bold: headerNum > 0
		text: "ciao"
		color: "#fcfcfc"
		wrapMode: TextEdit.Wrap
		tabStopDistance: checkboxelement.width
		textFormat: TextEdit.PlainText //enableTextFormat? (block.Type === Block.Type.CodeBlock ? TextEdit.PlainText : TextEdit.MarkdownText) : TextEdit.PlainText

		Keys.onPressed: (event) => KeyHandler.key(event)

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
