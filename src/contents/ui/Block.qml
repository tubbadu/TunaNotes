import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0

import "parser.js" as Parser
import "keyHandler.js" as KeyHandler
import "blockFunctions.js" as BlockFunctions
import "syntaxDefinition.js" as SyntaxDefinition

Item{
	id: block
	width: parent? parent.width : 0
	height: (type == Block.Type.CodeBlock)? background.height + syntaxNameField.height/2 + 5 : background.height

	enum Type{
		PlainText,
		Quote,
		DotList,
		CheckList,
		CodeBlock
	}
	property int type: Block.Type.PlainText
	property alias text: txt.text
	property string setText: "*error*" // used to set an initial value
	property int setType: -1
	property int setTabnum: 0
	property int tabNum: 0
	property alias checked: checkboxelement.checked
	property int headerNum: 0
	property alias syntaxHighlightning: syntaxNameField.text
	property var parseResult//: Parser.parseMarkdownLine(setText)
	property alias cursorPosition: txt.cursorPosition
	property alias selectedText: txt.selectedText
	property alias length: txt.length
	property var keyHandler: KeyHandler
	property int delta: 0

	property font normalFont
	normalFont.pixelSize: BlockFunctions.textSize()
	normalFont.bold: headerNum > 0

	property var forceFocus: BlockFunctions.forceFocus
	property var setCursorPosition: BlockFunctions.setCursorPosition 
	property var up: BlockFunctions.up 
	property var down: BlockFunctions.down 
	property var mergeBlocks: BlockFunctions.mergeBlocks 
	property var newBlock: BlockFunctions.newBlock
	property var getType: BlockFunctions.getType

	Component.onCompleted:{
		//console.warn(type, tabNum)
		text = setText
		if(setType == -1){
			BlockFunctions.getType()
		} else {
			//text = parseResult.plainText
			block.type = block.setType
		}
		if(setTabnum == -1) {
			//block.tabNum = 
		} else {
			//block.tabNum = block.setTabnum
		}
		//console.warn(type, tabNum)
	}

	TextField{
		id: syntaxNameField
		visible: (type == Block.Type.CodeBlock)
		text: "text"
		anchors.right: parent.right
		anchors.rightMargin: height/2
		z: 10
		horizontalAlignment: TextInput.AlignHCenter
		onTextChanged: {
			syntaxHighlightning = text.trim()
		}
		onFocusChanged: {
			if(focus){
				selectAll()
			}
		}
		onEditingFinished: {
			if(text.trim().length < 1){
				text = "text"
			}
		}
		onAccepted: {
			forceFocus()
		}
		onVisibleChanged: {
			if(visible){
				delta = 30
			} else {
				delta = 0
			}
		}
	}

	Rectangle{
		id: background
		//width: parent.width
		height: (type == Block.Type.CodeBlock)? txt.height + syntaxNameField.height/2 + 5 : txt.height
		color: type == Block.Type.CodeBlock? Qt.rgba(0.5, 0.5, 0.5, 0.15) : "transparent"
		border.color: type == Block.Type.CodeBlock? Qt.rgba(0.5, 0.5, 0.5, 0.75) : "transparent"
		border.width: 1
		radius: 5
		y: (type == Block.Type.CodeBlock)? syntaxNameField.height/2 : 0
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.rightMargin: 5
		anchors.leftMargin: 5

		RowLayout{
			y: (type == Block.Type.CodeBlock)? syntaxNameField.height/2 : 0
			id: row
			width: block.width
			height: txt.height
			spacing: 0

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
				//Layout.maximumHeight: txt.lineHeight
				Layout.fillHeight: true
			}	
			
			TextEdit{
				id: txt
				property int lineHeight: height / lineCount
				Layout.fillWidth: true
				Layout.leftMargin: 5
				Layout.rightMargin: 5
				font: type == Block.Type.CodeBlock? fixedFont : normalFont
				color: Kirigami.Theme.textColor
				selectionColor: Kirigami.Theme.highlightColor
				selectedTextColor: Kirigami.Theme.highlightedTextColor
				selectByMouse: true
				wrapMode: (type == Block.Type.CodeBlock)? TextEdit.Wrap : TextEdit.Wrap // TODO implement scrollable codeblocks
				tabStopDistance: checkboxelement.width
				//textFormat: TextEdit.RichText

				Keys.onPressed: (event) => KeyHandler.key(event)

				onFocusChanged: {
					// needed to set the current item on the clicked element
					if(focus && (document.currentIndex !== index)){
						document.currentIndex = index
					}
				}

				SyntaxHighlighter{
					property string defName: SyntaxDefinition.getLanguageName(syntaxHighlightning)
					textEdit: ((type == Block.Type.CodeBlock) && (defName != "None") && (defName != undefined))? txt : dump
					definition: defName
				}
				TextEdit{
					id: dump
					visible: false
				}
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
