import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser
import "keyHandler.js" as KeyHandler

import Launcher 1.0
import FileManager 1.0

ListView {
	id: listView
	width: parent.width
	height: parent.height
	//height: listView.contentHeight

	property string fileName: "/home/tubbadu/Desktop/TODO.md"

	model: blockModel
	delegate: blockDelegate
	highlight: highlight
	highlightFollowsCurrentItem: true
	highlightMoveDuration: 0
	highlightResizeDuration: 0
	cacheBuffer: 999999999//*999999999

	property var remove: blockModel.remove
	
	Component.onCompleted:{
		readFile()
	}

	function readFile(){
		let file = filemanager.read(fileName);
		let lines = Parser.splitStringExceptInCodeBlocks(file);
		for(let i=0; i<lines.length; i++){
			//addBlock(lines[i])
			blockModel.append({set_text: lines[i], set_type: -1})
		}
		document.currentIndex = 0
		document.currentItem.forceFocus()
		document.currentItem.setCursorPosition(-1)
	}

	function save(){
		filemanager.write(fileName, Parser.exportMarkdown())
	}

	ListModel {
		id: blockModel
	}

	Component {
        id: blockDelegate
		Block{
			id: blk
			setText: set_text
			setType: set_type
			//width: parent? parent.width : 0
			//height: parent? parent.height : 0
		}
    }

	Component {
		id: highlight
		Rectangle {
			width: 180
			height: 40
			color: window.active? Kirigami.Theme.alternateBackgroundColor : "transparent";
			//border.color: window.active? Kirigami.Theme.hoverColor : "transparent";
			//border.width: 1
		}
	}

	Keys.onPressed: (event) => KeyHandler.globalKey(event)
}
