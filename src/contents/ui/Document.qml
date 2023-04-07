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
	property bool unsaved: false
	property var remove: blockModel.remove
	readonly property var noSelection: [-1, -1]
	property var selection: noSelection

	model: blockModel
	delegate: blockDelegate
	highlight: highlight
	highlightFollowsCurrentItem: true
	highlightMoveDuration: 0
	highlightResizeDuration: 0
	//cacheBuffer: 999999999//*999999999
	
	Component.onCompleted:{
		readFile()
	}

	onCountChanged: {
		unsaved = true
	}

	function readFile(){
		let file = filemanager.read(fileName);
		let lines = Parser.splitStringExceptInCodeBlocks(file);
		for(let i=0; i<lines.length; i++){
			blockModel.append({set_text: lines[i], set_type: -1, set_tabnum: -1, set_headernum: 0})
		}
		document.currentIndex = 0
		document.currentItem.forceFocus()
		document.currentItem.setCursorPosition(-1)
		console.warn("done loading file")
		document.unsaved = false // does not work: syntax highlighting breaks everything
	}

	function save(){
		filemanager.write(fileName, Parser.exportMarkdown())
		console.warn("saved")
		unsaved = false
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
			setTabnum: set_tabnum
			setHeadernum: set_headernum
			//width: parent? parent.width : 0
			//height: parent? parent.height : 0
			Rectangle{
				id: selection
				anchors.fill: parent
				color: parent.selected? Kirigami.Theme.highlightColor : "transparent"
				z: -100
			}
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

	Clipboard{
		id: clipboard
	}

	Keys.onPressed: (event)=> KeyHandler.globalKey(event)
}
