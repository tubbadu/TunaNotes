/*
 *   SPDX-FileCopyrightText: 2022 Tubbadu <tubbadu@gmail.com>
 *
 *   SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebEngine 1.5
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents // for Menu+MenuItem
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0



Item {
	id: root
	property string filePath: Plasmoid.configuration.filePath
	property int fullHeight: Plasmoid.configuration.fullHeight
	property int fullWidth: Plasmoid.configuration.fullWidth
	property string textColor: Plasmoid.configuration.textColor
	property string textBackground: Plasmoid.configuration.textBackground
	property string textSelectionBackground: Plasmoid.configuration.textSelectionBackground
	property string activeBlockBackground: Plasmoid.configuration.activeBlockBackground
	property string customIcon: Plasmoid.configuration.customIcon
	property int textSize: Plasmoid.configuration.textSize

	PlasmaCore.IconItem{
		id: iconItem
		Plasmoid.icon: customIcon
	}

	Component.onCompleted: {
		openMarkdown()
		//Plasmoid.addEventListener('ConfigChanged', configChanged);
	}
	
	/*function configChanged(){ // dont know if useful or not
		root.filePath = plasmoid.readConfig("filePath");
		root.fullHeight = plasmoid.readConfig("fullHeight");
		root.fullWidth = plasmoid.readConfig("fullWidth");
		root.textColor = plasmoid.readConfig("textColor");
		root.textBackground = plasmoid.readConfig("textBackground");
		root.textSelectionBackground = plasmoid.readConfig("textSelectionBackground");
		root.textSize = plasmoid.readConfig("textSize")
		root.customIcon = plasmoid.readConfig("customIcon")
	}*/

	function openFile(fileUrl) {
		var request = new XMLHttpRequest();
		request.open("GET", fileUrl, false);
		request.send(null);
		return request.responseText;
	}

	function saveFile(fileUrl, text) {
		var request = new XMLHttpRequest();
		request.open("PUT", fileUrl, false);
		request.send(text);
		return request.status;
	}

	function exportMarkdown(){
		let doc = lView.itemAtIndex(0).getText()
		for(let i=1; i<lView.model.count; i++){
			doc = doc + "\n" + lView.itemAtIndex(i).getText()
		}
		saveFile(filePath, doc)
	}

	function openMarkdown(){
		lModel.clear()
		let doc = openFile(filePath).split("\n")
		for (let i=0; i<doc.length; i++){
			lView.addBlock(-1, doc[i])
			lView.itemAtIndex(i).textFormat(doc[i])
		}
	}
	
	Layout.preferredWidth: fullWidth
	Layout.preferredHeight: fullHeight
	Rectangle {
		anchors.fill: parent
		color: textBackground
		ColumnLayout{
			id: colLay
			spacing: 10
			anchors.fill: parent

			Button {
				id: butt
				visible: false
				text: "aa"
				anchors.right: parent.right
				onClicked: text = "lModel.get(i).text"//exportMarkdown() //lView.addBlock(0)
			}

			ListModel{
				id: lModel
			}

			Component {
				id: block
				Rectangle {
					default property alias data: col.data
					implicitWidth: colLay.width 
					implicitHeight: col.implicitHeight
					color: (tEdit.focus ? activeBlockBackground : textBackground) // change colors
					property string formatted: ""
					property bool isCheckbox: false
					property int titleNum: 0
					property bool isChecked: false
					property bool isBullet: false
					property bool isQuote: false
					property bool isDivider: false
					property bool dividerDouble: false
					property int spacerNum: 0
					
					Format {
						id: format
					}
					
					function textFormat(txt){
						let f = format.format(txt)
						formatted = f["formatted"]
						isCheckbox = f["isCheckbox"]
						isChecked = f["isChecked"]
						isBullet = f["isBullet"]
						spacerNum = f["spacerNum"]
						isQuote = f["isQuote"]
						isDivider = f["isDivider"]
						dividerDouble = f["dividerDouble"]
						titleNum = f["titleNum"]
					}
					function setAsCurrentItem(){
						lView.currentIndex = index
					}
					function setFocused(){
						tEdit.focus = true
					}
					function addText(txt){
						tEdit.text = tEdit.text + txt
					}

					function getText(){
						return tEdit.text
					}
					function setCursorPosition(pos){
						tEdit.cursorPosition = pos
					}
					function getLength(){
						return tEdit.length
					}
					function deleteCurrentItemAndMoveUp(){
						if (index > 0){
							lView.decrementCurrentIndex()
							let setIndex = lView.currentItem.getLength()
							lView.currentItem.addText(tEdit.text)
							lView.currentItem.setCursorPosition(setIndex)
							lModel.remove(index)
						} else {
							// is the first block, do nothing
						}
					}

					function deleteNextItemAndMoveUp(){ // TODO move cursor
						/* 
						* check if item is last
						* if last, do nothing
						* otherwise, delete next item and copy it's text to this
						*/

						if (index < lModel.count-1){
							let setIndex = tEdit.cursorPosition
							tEdit.text = tEdit.text + lView.itemAtIndex(index+1).getText()
							tEdit.cursorPosition = setIndex
							lModel.remove(index+1)
						} else {
							// is the last block, do nothing
						}
					}
					onFocusChanged: {
						tEdit.focus = true
					}
					Column {
						id: col
						anchors.fill: parent
						spacing: 20
						
						TextEdit {
							id: tEdit
							property string ssetText: setText
							width: parent.width
							height: htmlView.height // this may cause a lot of problem !WARNING!
							selectByMouse: true
							selectionColor: textSelectionBackground
							text: setText
							font.bold: ((titleNum != 0) ? true : false)
							font.pixelSize: ((titleNum != 0) ? textSize*2*(6-titleNum)/5 : textSize) //htmlView.contentHeight * 0.7//textSize
							/* title preferred font size multiplications:
							# x2
							## x1.5
							### x1.2
							#### x1.025
							##### dunno
							*/ 
							color: textColor
							wrapMode: TextEdit.Wrap

							onFocusChanged: {
								row.visible = !focus
								visible = focus
								if (focus) {
									setAsCurrentItem()
								}
								
							}

							Component.onCompleted:{
								focus = true
							}
							onEditingFinished: {
								// perde fuoco
								exportMarkdown()
							}

							Keys.onPressed: {
								let delKey = 16777219
								let cancKey = 16777223
								let tabKey = 16777217
								let shiftTabKey = 16777218
								let escKey = 16777216
								let kp_enterKey = 16777221
								let enterKey = 16777220

								//saveFile("/home/tubbadu/log.txt", event.key) // I used this just for debug
								if (event.key == delKey){
									if(cursorPosition == 0){
										event.accepted = true;
										deleteCurrentItemAndMoveUp()
									}
								} else if (event.key == cancKey){
									if(cursorPosition == length){
										event.accepted = true;
										deleteNextItemAndMoveUp()
									}
								} else if (event.key == tabKey){
									event.accepted = true;
									tEdit.text = "\t" + tEdit.text
								} else if (event.key == shiftTabKey){
									event.accepted = true;
									tEdit.text = tEdit.text.replace(/^\t/g, "")
								} else if (event.key == escKey){
									//focus = false
								} else if (event.key == enterKey || event.key == kp_enterKey){
									// on enter pressed
									event.accepted = true
									if (lView.currentIndex + 1 < lView.model.count){
										lView.addBlock(lView.currentIndex + 1)
									} else {
										lView.addBlock(-1)
									}
								}
							}

							Timer {
								interval: 100
								running: tEdit.focus && Plasmoid.expanded
								repeat: true
								onTriggered: {
									textFormat(tEdit.text) 
									lView.focus = true
								}
							}
						}

						Row{
							id: row
							
							Rectangle {
								id: spacer
								anchors.verticalCenter: parent.verticalCenter
								width: 20 * spacerNum
								height: 1
								color: null
								visible: !isDivider
								
							}
							Rectangle {
								id: divider // can surely be improved
								visible: isDivider
								height: 10
								width: root.width
								color: null 
								
								Rectangle {
									
									anchors.verticalCenter: parent.verticalCenter
									anchors.horizontalCenter: parent.horizontalCenter
									width: parent.width*0.99
									height: 2*2
									color: ( !dividerDouble ? "null" : textColor)
								}
								Rectangle {
									
									anchors.verticalCenter: parent.verticalCenter
									anchors.horizontalCenter: parent.horizontalCenter
									width: parent.width*0.99
									height: 2
									color: ( !dividerDouble ? textColor : textBackground)
								}
							}
						
							Row {
								id: quote
								visible: isQuote && !isDivider
								anchors.verticalCenter: parent.verticalCenter
								height: parent.height
								width: 4
								Rectangle {
									anchors.verticalCenter: parent.verticalCenter
									width: 3
									height: parent.height
									color: "#3DAEE9"
								}
								Rectangle {
									anchors.verticalCenter: parent.verticalCenter
									width: 3
									height: parent.height
									color: null
								}
							}
							
							CheckBox {
								id: checkbox
								anchors.verticalCenter: parent.verticalCenter
								visible: isCheckbox
								checked: isChecked
								onCheckedChanged: {
									let ch
									if(checkState == Qt.Checked) {
										ch="* [x] "
									}
									else {
										ch="* [ ] "
									}
									tEdit.text = tEdit.text.replace(/\* \[.\] /g, ch)
								}
							}
							Text {
								id: bullet
								anchors.verticalCenter: parent.verticalCenter
								visible: isBullet
								text: "  •  "
								color: textColor 
								font.pixelSize: textSize
							}
							Text {
								id: htmlView
								anchors.verticalCenter: parent.verticalCenter
								font.pixelSize: textSize
								textFormat: Text.RichText
								wrapMode: TextEdit.Wrap
								text: formatted
								width: root.width
								color: textColor

								function clicked(){
									tEdit.focus = true
								}

								MouseArea {
									anchors.fill: parent
									onClicked: {
										htmlView.clicked()
									}
								}
							}
						}
					}
				}
			}
			ListView{
				id: lView
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				model: lModel
				delegate: block
				snapMode: ListView.NoSnap
				focus:  true
				ScrollBar.vertical: ScrollBar {
					active: true
				}
				property int n: 0

				
				function addBlock(index, txt=""){ // to be removed
					let prop = {"setText": txt, "setMarkdown": "# markdown `prova` " + n, "setFocused": true}
					if(index == -1) {
						model.append(prop)
					}
					model.insert(index, prop)
					incrementCurrentIndex()
					let setIndex = currentItem.getLength()
					currentItem.setCursorPosition(setIndex)
					n=n+1
				}

				Component.onCompleted: {
					if (lView.model.count == 0) {
						lView.addBlock(0)
					}
				}

				MouseArea{
						anchors.bottom: parent.bottom
						anchors.left: parent.left
						anchors.right: parent.right

						height: lView.height - lView.contentHeight
						onClicked: {
							// give focus to the last element
							lView.currentIndex = lView.count-1
						}
					}

			}
		}
	}
}