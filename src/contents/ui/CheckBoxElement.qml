import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0


Item{
	property alias checked: checkbox.checked
	visible: block.type == Block.Type.CheckList
	//height: checkbox.height
	width: checkbox.width
	Layout.alignment: Qt.AlignTop
	Layout.preferredHeight: txt.lineHeight * 1.3
	CheckBox{
		width: 20
		id: checkbox
		//anchors.right: parent.right
		//anchors.verticalCenter: parent.vericalCenter
		anchors.centerIn: parent
		contentItem: Item{
			width: 0
		}
	}
}