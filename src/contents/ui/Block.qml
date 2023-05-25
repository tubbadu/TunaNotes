import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import PlainTextFormat 1.0

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
	property string extext

	property bool loadingFinished: false
	property int tabNum: 0
	property alias checked: checkboxelement.checked
	property int headerNum: 0
	property alias syntaxHighlightning: syntaxNameField.text
	property var parseResult
	property alias cursorPosition: txt.cursorPosition
	property alias selectedText: txt.selectedText
	property alias selectionEnd: txt.selectionEnd
	property alias selectionStart: txt.selectionStart
	property alias length: txt.length
	property var keyHandler: KeyHandler
	property int delta: 0 // what is it used for?
	property var selection: document.selection
	property bool isSelected: Math.min(document.selection.start.block, document.selection.end.block) < index && index < Math.max(document.selection.start.block, document.selection.end.block)
	//property int cursorStart: (index === Math.min(document.selection.start.block, document.selection.end.block))? document.selection.start.cursor : 0
	//property int cursorEnd: (index === Math.max(document.selection.start.block, document.selection.end.block))? document.selection.end.cursor : txt.length
	property var sync: BlockFunctions.sync

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
	property var deselect: txt.deselect
	property var positionAt: txt.positionAt
	property var select: txt.select

	Component.onCompleted:{
		if(type == -1){
			BlockFunctions.getType()
		}

		if(index == document.lastLoadedIndex){
			// the last block has been loaded
			document.lastLoadedIndex = -1
			document.unsaved = false
		}
	}

	onSelectionChanged: {
		if(isSelected){
			txt.selectAll()
		} else {
			txt.deselect()
		}
	}

	SyntaxNameField{
		id: syntaxNameField
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
			
			BlockTextEdit{
				id: txt
			}
		}
	}
	onFocusChanged: {
		// needed to set text focus when selecting block with arrows
		if(focus && !txt.focus){
			txt.focus = true
		}
	}

	onTextChanged: {
		if(text != extext){
			document.unsaved = true
			extext = text
		}
	}
	onSyntaxHighlightningChanged:{
		document.unsaved = true
	}
	onHeaderNumChanged:{
		document.unsaved = true
	}
	onCheckedChanged:{
		document.unsaved = true
	}
	onTypeChanged:{
		document.unsaved = true
	}
	onTabNumChanged:{
		document.unsaved = true
	}
}
