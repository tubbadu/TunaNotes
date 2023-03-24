import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser

import Launcher 1.0
import FileManager 1.0

Item{
	width: parent.width
	height: parent.height

	property alias currentIndex: listView.currentIndex
	property alias currentItem: listView.currentItem
	property alias count: listView.count
	function itemAtIndex(i){
		listView.itemAtIndex(i)
	}
	function remove(i){
		blockModel.remove(i)
	}
	
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
			width: 180; height: 40
			color: window.active? "#30586E" : "transparent";
			radius: 5
			border.color: window.active? "#3DAEE9" : "transparent";
			border.width: 1
		}
	}

	ListView {
		id: listView
        anchors.fill: parent // todo remove
		anchors.top: parent.top
		anchors.right: parent.right
		anchors.left: parent.left
		//height: 5000
        model: blockModel
        delegate: blockDelegate
		highlight: highlight
   		highlightFollowsCurrentItem: true
		highlightMoveDuration: 0
		highlightResizeDuration: 0
		rebound: Transition {
			NumberAnimation {
				properties: "x,y"
				duration: 0
				easing.type: Easing.Linear
			}
		}
    }
}
