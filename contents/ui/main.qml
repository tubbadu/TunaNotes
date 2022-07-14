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
import QtQml 2.15



Item {
	id: root

	property bool debug: false

	property bool useDefault: Plasmoid.configuration.useDefault
	property string filePath: Plasmoid.configuration.filePath
	property int fullHeight: Plasmoid.configuration.fullHeight
	property int fullWidth: Plasmoid.configuration.fullWidth
	property string customIcon: Plasmoid.configuration.customIcon
	property int textSize: Plasmoid.configuration.textSize

	property color textColor: (useDefault? PlasmaCore.Theme.palette.windowText : Plasmoid.configuration.textColor)
	property color textBackground: (useDefault? "transparent" : Plasmoid.configuration.textBackground)
	property color textSelectionBackground: (useDefault? PlasmaCore.Theme.palette.highlight : Plasmoid.configuration.textSelectionBackground)
	property color activeBlockBackground: (useDefault? Qt.rgba(1-PlasmaCore.Theme.backgroundColor.r, 1-PlasmaCore.Theme.backgroundColor.g, 1-PlasmaCore.Theme.backgroundColor.b, 0.2) : Plasmoid.configuration.activeBlockBackground)

	PlasmaCore.IconItem{
		id: iconItem
		Plasmoid.icon: customIcon
	}

	Component.onCompleted: {
		openMarkdown()		
	}

	Text {
		id: log
		visible: debug
		color: "red"
		text: "no log"
		z: 100
	}

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
			lView.addBlock(-1, doc[i], true)
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
					property string isOrdered: "" //change name TODO
					property bool isQuote: false
					property bool isDivider: false
					property bool dividerDouble: false 
					property int spacerNum: 0
					property int tabNum: 0
					/**********************/
					property string autoAddedFormatting: setAutoAddedFormatting
					
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
						isOrdered = f["isOrdered"]
						tabNum = f["tabNum"]
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
						if(pos == -1){
							tEdit.cursorPosition = tEdit.length
						}
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
					function enterPressed(){
						//format text again
						textFormat(tEdit.text)

						// check if nothing has been written after creation
						//log.text = "<" + autoAddedFormatting + ">, <" + tEdit.text + ">"
						if (autoAddedFormatting != "null" && tEdit.text == autoAddedFormatting && tEdit.text != ""){
							//then just erase current block text and don't create another
							tEdit.text = ""
							return
						}

						//copy formatting if needed
						let txt = "\t".repeat(tabNum)
						if(isBullet){
							txt += "* "
						} else if (isCheckbox){
							txt += "* [ ] "
						} else if (isQuote){
							txt += "> "
						} else if (isOrdered != ""){
							let x = isOrdered.trim().replace(/^([0-9]+). .+/g, "$1")
							x++
							if (!isNaN(x)){
								txt += x + ""
								txt += isOrdered.trim().replace(/[0-9]+(.)/g, "$1") + " "
							} else {
								console.log("error")
							}
						}

						// check if the cursor is at the end of the line
						if(tEdit.cursorPosition != tEdit.length){
							let startIndex = txt.length
							log.text = "splitting line!"
							txt += tEdit.text.slice(tEdit.cursorPosition, tEdit.length)
							tEdit.text = tEdit.text.slice(0, tEdit.cursorPosition)
							textFormat(tEdit.text)
							// create block
							if (lView.currentIndex + 1 < lView.model.count){
								lView.addBlock(lView.currentIndex + 1, txt, true)
							} else {
								lView.addBlock(-1, txt, true)
							}

							// set now cursor at the beginning of the line
							lView.currentItem.setCursorPosition(startIndex)
							return
						}

						// create block
						if (lView.currentIndex + 1 < lView.model.count){
							lView.addBlock(lView.currentIndex + 1, txt)
						} else {
							lView.addBlock(-1, txt)
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
							//font.pixelSize: ((titleNum != 0) ? textSize*2*(6-titleNum)/5 : textSize) //htmlView.contentHeight * 0.7//textSize
							font.pixelSize: ((titleNum == 1) ? textSize*2 : ((titleNum == 2) ? textSize*1.5 : ((titleNum == 3) ? textSize*1.2 : ((titleNum == 4) ? textSize*1.025 : ((titleNum == 5) ? textSize*0.75 : textSize)))))
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
								//autoAddedFormatting = (text != "" ? text : null) //setText?
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
								let upKey = 16777235
								let downKey = 16777237
								let leftKey = 16777234
								let rightKey = 16777236
								let pageUpKey = 16777238
								let pageDownKey = 16777239
								//log.text = event.key

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
									enterPressed()
								} else if (event.key == leftKey){
									if(tEdit.cursorPosition == 0){ // if is at the beginning of the line
										event.accepted = true
										if(lView.currentIndex != 0){ // check if is not the first block
											// then go to the upper block and place cursor at the end
											lView.decrementCurrentIndex()
											lView.currentItem.setCursorPosition(-1)
										}
									}
								} else if (event.key == rightKey){
									if(tEdit.cursorPosition == tEdit.length){ // if is at the end of the line
										event.accepted = true
											if(lView.currentIndex != lView.count){ // check if is not the last block
												// then go to the upper block and place cursor at the end
												lView.incrementCurrentIndex()
												lView.currentItem.setCursorPosition(0) //lView.currentItem.tEdit.length											}
										}
									}
								} else if (event.key == pageUpKey){
									event.accepted = true
									lView.setCurrentIndex(0)
								} else if (event.key == pageDownKey){
									event.accepted = true
									lView.setCurrentIndex(-1)
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
								width: 30 * spacerNum + (isBullet ? -25 : 0) + (isCheckbox ? -25 : 0) + (isOrdered ? -25 : 0)
								height: 1
								color: null //"red"
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
								id: ordered
								anchors.verticalCenter: parent.verticalCenter
								visible: (isOrdered != "")
								text: "  " + isOrdered.trim() + "  "
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

				
				function addBlock(index, txt="", isStartup=false){ 
					let prop = {"setText": txt, "setAutoAddedFormatting": (((txt == "") || (isStartup)) ? "null" : txt)}
					if(index == -1) {
						model.append(prop)
					}
					model.insert(index, prop)
					incrementCurrentIndex()
					let setIndex = currentItem.getLength()
					currentItem.setCursorPosition(setIndex)
					n=n+1
				}

				function setCurrentIndex(i){
					if(i == -1){
						currentIndex = model.count - 1
					} else {
						currentIndex = i
					}
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
			Item{
				anchors.top: lView.top
				anchors.right: lView.right
				width: 35//Math.round(PlasmaCore.Units.gridUnit * 1.25)
        		height: width
				
				PlasmaComponents.ToolButton {
					id: pin
					checkable: true
					iconSource: "pin"
					anchors.fill: parent
					z: 10
					visible: plasmoid.compactRepresentationItem && plasmoid.compactRepresentationItem.visible
					onCheckedChanged: plasmoid.hideOnWindowDeactivate = !checked
				}
			}
			
		}
	}
}