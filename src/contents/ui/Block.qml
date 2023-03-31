import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser
import "keyHandler.js" as KeyHandler
import "blockFunctions.js" as BlockFunctions


Rectangle{
	id: block
	width: parent.width
	height: row.height
	color: type == Block.Type.CodeBlock? Qt.rgba(0.5, 0.5, 0.5, 0.15) : "transparent"
	radius: 5

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
	property int tabNum: 0
	property bool checked: false
	//property bool enableTextFormat: true
	property int headerNum: 0
	property var parseResult: Parser.parseMarkdownLine(setText)
	property alias cursorPosition: txt.cursorPosition
	property alias length: txt.length

	property font normalFont
	normalFont.pixelSize: BlockFunctions.textSize()
	normalFont.bold: headerNum > 0

	property var forceFocus: BlockFunctions.forceFocus
	property var setCursorPosition: BlockFunctions.setCursorPosition 
	property var up: BlockFunctions.up 
	property var down: BlockFunctions.down 
	property var mergeBlocks: BlockFunctions.mergeBlocks 
	property var newBlock: BlockFunctions.newBlock 

	

	Component.onCompleted:{
		if(setType == -1){
			BlockFunctions.getType()
		} else {
			text = parseResult.plainText
			block.type = block.setType
		}
		
	}
	RowLayout{
		id: row
		width: parent.width
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
			Layout.maximumHeight: txt.lineHeight
		}	
		
		TextEdit{
			id: txt
			property int lineHeight: height / lineCount
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignTop
			Layout.topMargin: 2
			Layout.leftMargin: 3
			font: type == Block.Type.CodeBlock? fixedFont : normalFont
			text: "ciao"
			color: Kirigami.Theme.textColor
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

		
	}
	onFocusChanged: {
			// needed to set text focus when selecting block with arrows
			if(focus && !txt.focus){
				txt.focus = true
			}
		}
}
