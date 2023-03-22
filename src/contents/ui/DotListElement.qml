import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0

Item{
	visible: block.type == Block.Type.DotList
	//height: checkbox.height
	//width: checkbox.width
	Layout.alignment: Qt.AlignTop
	Layout.preferredHeight: txt.lineHeight * 1.3
	
	Rectangle{
		color: "#fcfcfc"
		height: txt.lineHeight / 5
		width: height
		radius: height / 2
		anchors.right: parent.right
		anchors.verticalCenter: parent.verticalCenter
	}
}