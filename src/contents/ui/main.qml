// Includes relevant modules used by the QML
import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0
import "parser.js" as Parser

import Launcher 1.0
import FileManager 1.0

Kirigami.ApplicationWindow {
	id: window
	minimumWidth: 300
    minimumHeight: 300

	property string unsavedToken: document.unsaved? "*" : ""
	title: i18nc("@title:window", "TunaNotes") + unsavedToken
	Launcher {
        id: launcher
    }
	FileManager{
		id: filemanager
	}

	Kirigami.ActionToolBar { // top left toolbar
		//anchors.top: parent.top
		actions: [
			Kirigami.Action { 
				icon.name: "irc-operator" 
				onTriggered: document.currentItem.keyHandler.hashtagPressed()
			},  
			Kirigami.Action { 
				icon.name: "format-list-unordered" 
				onTriggered: document.currentItem.keyHandler.dotPressed()
			}, 
			Kirigami.Action { 
				icon.name: "format-text-blockquote" 
				onTriggered: document.currentItem.keyHandler.quotePressed()
			}, 
			Kirigami.Action { 
				icon.name: "format-text-code" 
				onTriggered: document.currentItem.keyHandler.backtickPressed()
			}, 
			Kirigami.Action { 
				icon.name: "gnumeric-object-checkbox" 
				onTriggered: document.currentItem.keyHandler.checkListToggle()
			}, 
			Kirigami.Action { 
				icon.name: "format-indent-more" 
				onTriggered: document.currentItem.keyHandler.tabPressed()
			}, 
			Kirigami.Action { 
				icon.name: "format-indent-less" 
				onTriggered: document.currentItem.keyHandler.backtabPressed()
			},
			Kirigami.Action { 
				icon.name: "edit-clear" 
				onTriggered: document.currentItem.keyHandler.removeFormatting()
			}
		]
	}

	Kirigami.ActionToolBar { // top right toolbar
		anchors.right: parent.right
		actions: [
			Kirigami.Action {
			text: "Save" 
			icon.name: "document-save" 
			onTriggered: document.save()
		}]
	}

	pageStack.initialPage: Kirigami.ScrollablePage { // scrollablepage does not successfully set focus at the beginning (fixable probably)
		id: page
		Layout.fillWidth: true

		Document{
			id: document
		}
		
	}
}
