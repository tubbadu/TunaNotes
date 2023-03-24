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
		PlainText,
		Header,
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

	function getType(){
		text = parseResult.plainText
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
			type = Block.Type.Header
			headerNum = parseResult.headerNumber
			return
		}

		type = Block.Type.PlainText
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

	function keyHandler(event){
		var key = event.key
		if (key == Qt.Key_Enter || key == Qt.Key_Return) {
			enableTextFormat = false
			console.warn("enter");
			event.accepted = true;
			let subtext = text.substr(txt.cursorPosition, text.length)
			text = text.substr(0, txt.cursorPosition)
			newBlock(subtext);
			enableTextFormat = false
		} else if (key == Qt.Key_Down) {
			event.accepted = true;
			down();
		} else if (key == Qt.Key_Up) {
			event.accepted = true;
			up();
		} else if (key == Qt.Key_Delete) {
			if(txt.cursorPosition == txt.length && index < document.count-1){
				event.accepted = true;
				console.warn("marging this block to the previous one");
				mergeBlocks(index+1, index)
			}
		} else if (key == Qt.Key_Backspace) {
			if(txt.cursorPosition == 0){
				event.accepted = true;
				
				if (type == Block.Type.Header || type == Block.Type.PlainText ){
					if(headerNum > 0){
						headerNum--
					}
				}else if(type !== Block.Type.PlainText){
					type = Block.Type.PlainText
					console.warn("removing formatting");
				} else if(index > 0){
					console.warn("marging this block to the previous one");
					mergeBlocks(index, index-1)
				}
			}
		} else if(key == Qt.Key_Tab) {
			// todo add codeblock support
			event.accepted = true;
			tabNum++
		} else if(key == Qt.Key_Backtab) {
			// todo add codeblock support
			event.accepted = true;
			if(tabNum > 0){
				tabNum--
			}
		} else if(key == Qt.Key_NumberSign && cursorPosition == 0){
			if(type == Block.Type.PlainText || type == Block.Type.Header){
				event.accepted = true;
				type = Block.Type.Header
				if(headerNum < 6){
					headerNum++
				}
			}
		} else if(key == Qt.Key_Greater && cursorPosition == 0){
			// ignore the current formatting, just set it to quote or plaintext
			if(type == Block.Type.Quote){
				type = Block.Type.PlainText
			} else {
				type = Block.Type.Quote
			}
			event.accepted = true
		} else if((key == Qt.Key_Minus || key == Qt.Key_Plus || key == Qt.Key_Asterisk) && cursorPosition == 0){
			// ignore the current formatting, just set it to quote or plaintext
			if(type == Block.Type.DotList){
				type = Block.Type.PlainText
			} else {
				type = Block.Type.DotList
			}
			event.accepted = true
		} else if(key == Qt.Key_BracketRight && cursorPosition == 1 && text[0] == "["){
			// ignore the current formatting, just set it to quote or plaintext
			type = Block.Type.CheckList
			text = text.replace(/^\[/, "")
			event.accepted = true
		} 
		else if(key == Qt.Key_Space){
			// parse
		}
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
			// no type specified, calculate type
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
		textFormat: enableTextFormat? (block.Type === Block.Type.CodeBlock ? TextEdit.PlainText : TextEdit.MarkdownText) : TextEdit.PlainText

		Keys.onPressed: (event) => keyHandler(event)

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