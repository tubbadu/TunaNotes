import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser

import Launcher 1.0
import FileManager 1.0



ListView {
	id: listView
	width: parent.width
	height: parent.height
	//height: listView.contentHeight

	model: blockModel
	delegate: blockDelegate
	highlight: highlight
	highlightFollowsCurrentItem: true
	highlightMoveDuration: 0
	highlightResizeDuration: 0
	rebound: Transition {
		//enabled: false
		NumberAnimation {
			id: xx
			properties: "x,y"
			duration: 0
			//easing.type: Easing.Linear
			easing.amplitude: 0
			easing.overshoot: 0
			easing.period: 0
		}
	}

	

	/*property alias currentIndex: listView.currentIndex
	property alias currentItem: listView.currentItem
	property alias count: listView.count
	property var itemAtIndex: listView.itemAtIndex*/
	property var remove: blockModel.remove
	
	Component.onCompleted:{
		readFile()
	}

	function readFile(){
		let file = filemanager.read("/home/tubbadu/Desktop/TODO.md");
		let lines = Parser.splitStringExceptInCodeBlocks(file);
		for(let i=0; i<lines.length; i++){
			//addBlock(lines[i])
			blockModel.append({set_text: lines[i], set_type: -1})
		}
		document.currentIndex = 0
		document.currentItem.forceFocus()
		document.currentItem.setCursorPosition(-1)
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
			width: parent? parent.width : 0
		}
    }

	Component {
		id: highlight
		Rectangle {
			width: 180
			height: 40
			color: window.active? Kirigami.Theme.activeBackgroundColor : "transparent";
			radius: 5
			//border.color: window.active? Kirigami.Theme.hoverColor : "transparent";
			//border.width: 1
		}
	}

	
}
