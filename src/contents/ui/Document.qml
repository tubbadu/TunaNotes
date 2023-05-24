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

	property string fileName: "/home/tubbadu/code/Kirigami/TunaNotes/provaaa.md"
	property bool unsaved: false
	property var remove: blockModel.remove
	readonly property var noSelection: {
		"blockStart": -1,
		"blockEnd": -1,
		"cursorStart": -1,
		"cursorEnd": -1,
		"refresh": function(){document.selection = document.selection}
	} //[-1, -1]
	property var selection: noSelection
	property int lastLoadedIndex: -1

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

	onSelectionChanged: {
		if(selection !== noSelection){
			//document.currentItem.deselect() // there are probably better alternatives
		}
	}

	function readFile(){
		let file = filemanager.read(fileName);
		let lines = Parser.splitStringExceptInCodeBlocks(file);
		lastLoadedIndex = lines.length - 1
		for(let i=0; i<lines.length; i++){
			//blockModel.append({set_text: lines[i], set_type: -1, set_tabnum: -1, set_headernum: 0})
			//let IsLastLoaded = (i === lines.length-1);
			insertBlock({index: -1, new_text: lines[i]})//, isLastLoaded: (i === lines.length-1)})
		}
		document.currentIndex = 0
		document.currentItem.forceFocus()
		document.currentItem.setCursorPosition(-1)
	}

	function save(){
		if(unsaved){
			// first update the model
			document.currentItem.sync()
			// then save to file
			filemanager.write(fileName, Parser.exportMarkdown())
			console.warn("saved")
			unsaved = false
		}
	}

	/*function insert(new_pos=-1, new_text="", new_type=-1, new_tabnum=-1, new_headernum=0, new_syntaxhighlightning = ""){
		if(new_pos === -1){
			blockModel.append({set_text: new_text, set_type: new_type, set_tabnum: new_tabnum, set_headernum: new_headernum, set_syntaxhighlightning: new_syntaxhighlightning})
		} else {
			blockModel.insert(new_pos, {set_text: new_text, set_type: new_type, set_tabnum: new_tabnum, set_headernum: new_headernum, set_syntaxhighlightning: new_syntaxhighlightning})
		}
	}*/

	function insertBlock(values){ //new_pos=-1, new_text="", new_type=-1, new_tabnum=-1, new_headernum=0, new_syntaxhighlightning = "", isLastLoaded = false){
		let defaults = {
			index: -1,
			new_text: "",
			new_type: -1,
			new_tabnum: -1,
			new_headernum: 0,
			new_syntaxhighlightning: ""
		}
		let trueValues = {}
		// load default values where unspecified
		for (const [key, value] of Object.entries(defaults)) {
			if(values[key] === undefined){
				trueValues[key] = value
			} else {
				trueValues[key] = values[key]
			}
		}
		if(trueValues["index"] === -1){
			blockModel.append({set_text: trueValues["new_text"], set_type: trueValues["new_type"], set_tabnum: trueValues["new_tabnum"], set_headernum: trueValues["new_headernum"], set_syntaxhighlightning: trueValues["new_syntaxhighlightning"]})
		} else {
			blockModel.insert(trueValues["index"], {set_text: trueValues["new_text"], set_type: trueValues["new_type"], set_tabnum: trueValues["new_tabnum"], set_headernum: trueValues["new_headernum"], set_syntaxhighlightning: trueValues["new_syntaxhighlightning"]})
		}
		if(document.lastLoadedIndex == -1){
			console.warn("unsaved set true")
			document.unsaved = true
		}
	}

	function getIndexFromCoordinates(x, y){
		for(let i=0; i<document.count; i++){
			if(document.itemAtIndex(i) === document.itemAt(x, y)){
				return i;
			}
		}
		console.warn("not found")
		return -1;
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
			setSyntaxHighlightning: set_syntaxhighlightning
			//loadingFinished: isLastLoaded
			//width: parent? parent.width : 0
			//height: parent? parent.height : 0
			/*Rectangle{
				id: selectionxxx
				anchors.fill: parent
				color: parent.selected? Kirigami.Theme.highlightColor : "transparent"
				z: -100
			}*/
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
