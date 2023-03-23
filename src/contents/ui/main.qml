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
	/*onActiveFocusItemChanged: {
		//console.warn("activeFocusItem", activeFocusItem)
		if(activeFocusItem === page){
			console.warn("now!!!")
			document.currentIndex = 5
		}
	}*/

	title: i18nc("@title:window", "Hello World")
	Launcher {
        id: launcher
    }
	FileManager{
		id: filemanager
	}

	// Initial page to be loaded on app load
	pageStack.initialPage: Kirigami.Page {
		id: page
		Layout.fillWidth: true
		
		//Layout.fillHeight: true

		Document{
			id: document
		}
	}
}