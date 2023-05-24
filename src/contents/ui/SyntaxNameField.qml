import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0

TextField{
		property int size: 150
		visible: (type == Block.Type.CodeBlock)
		text: "text"
		anchors.right: parent.right
		anchors.rightMargin: height/2
		width: parent.width > (size + anchors.rightMargin * 2) ? size : parent.width - anchors.rightMargin * 2
		//anchors.left: parent.width > (size + anchors.rightMargin + anchors.leftMargin) ? undefined : parent.left
		//anchors.leftMargin: height/2
		z: 10
		horizontalAlignment: TextInput.AlignHCenter

		onFocusChanged: {
			if(focus){
				selectAll()
				document.currentIndex = index
			}
		}
		onEditingFinished: {
			if(text.trim().length < 1){
				text = "text"
			} else if(text.trim().length !== text.length){
				console.warn("trimmed")
				text = text.trim()
			}
			sync()
		}
		onAccepted: {
			forceFocus()
		}
		onVisibleChanged: {
			if(visible){
				delta = 30
			} else {
				delta = 0
			}
		}
	}