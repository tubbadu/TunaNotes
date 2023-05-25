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
import "MouseAreaFunctions.js" as MouseAreaFunctions

TextEdit{
	property int lineHeight: height / lineCount
	property int startingSelection: -1
	property var linksCoordinates: BlockFunctions.getLinksCoordinates(text)
	property string hoveredLink: BlockFunctions.linkAtIndex(linksCoordinates, txt.positionAt(mousearea.mouseX, mousearea.mouseY))
	property bool isHoveringALink: (hoveredLink != "")

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
	textFormat: TextEdit.PlainText //AutoText
	//onLinkActivated: Qt.openUrlExternally(link)

	Keys.onPressed: (event) => KeyHandler.key(event)

	onFocusChanged: {
		sync()
		// needed to set the current item on the clicked element
		if(focus && (document.currentIndex !== index)){
			document.currentIndex = index
		}
		document.unselectAll()
	}

	onCursorPositionChanged: {
		focus = true
	}

	SyntaxHighlighter{
		property string defName: SyntaxDefinition.getLanguageName(syntaxHighlightning)
		textEdit: ((type == Block.Type.CodeBlock) && (defName != "None") && (defName != undefined))? txt : dump
		definition: defName
	}

	/*PlainTextFormat{ // DO NOT DELETE!
		id: plainTextFormat
		textDocument: txt.textDocument
		// todo add enable
	}*/

	TextEdit{
		id: dump // used only as secondary target
		visible: false
	}

	MouseArea{
		id: mousearea
		anchors.fill: parent
		preventStealing: true
		hoverEnabled: true
		cursorShape: isHoveringALink? Qt.PointingHandCursor : Qt.ArrowCursor

		onPressed: (mouse) => {
			//txt.startingSelection = txt.positionAt(mouse.x, mouse.y)
			document.selection.start.index = index
			document.selection.end.index = index
			document.selection.start.cursor = txt.positionAt(mouse.x, mouse.y)
			document.selection.end.cursor = txt.positionAt(mouse.x, mouse.y)
			document.selection.refresh()
			document.selectionMode = true
		}
		onReleased: (mouse) => {
			document.selectionMode = false
			if(txt.startingSelection === txt.positionAt(mouse.x, mouse.y + block.y)){
				MouseAreaFunctions.singleClick(mouse)
			} else if(!nothingSelected){
				txt.startingSelection = -1
			} else if(txt.startingSelection !== -1){
				/*txt.forceActiveFocus()
				txt.cursorPosition = txt.positionAt(mouse.x, mouse.y)
				txt.select(startingSelection, txt.positionAt(mouse.x, mouse.y))*/
				txt.startingSelection = -1
			}
			txt.startingSelection = -1
		}

		onMouseXChanged: {
			if(document.selectionMode){
				let i = document.indexAt(mouseX, mouseY + block.y)
				let item = document.itemAtIndex(i)
				if(item){
					document.selection.end.index = i
					document.selection.end.cursor = item.positionAt(mouseX, mouseY + block.y - item.y)
					document.selection.refresh()
				} else {
					console.warn("WARNING: invalid item at index", i)
				}
			}
		}

		onMouseYChanged: {
			if(document.selectionMode){
				let i = document.indexAt(mouseX, mouseY + block.y)
				let item = document.itemAtIndex(i)
				if(item){
					document.selection.end.index = i
					document.selection.end.cursor = item.positionAt(mouseX, mouseY + block.y - item.y)
					document.selection.refresh()
					document.itemAtIndex(document.selection.end.index).select(document.selection.end.cursor, 0)
				} else {
					console.warn("WARNING: invalid item at index", i)
				}
			}
		}

		onCanceled: {
			txt.startingSelection = -1
			console.warn("WARNING: canceled selection")
		}

		onDoubleClicked: (mouse) => {
			MouseAreaFunctions.doubleClick(mouse)
		}

		// todo add triple click select all!
	}
}
