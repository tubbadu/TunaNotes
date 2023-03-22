import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0

Item{
	visible: block.type == Block.Type.Quote
	//height: checkbox.height
	//width: checkbox.width
	Layout.alignment: Qt.AlignTop
	Layout.fillHeight: true
	
	Rectangle{
		color: "cyan"
		height: parent.height
		width: 3
		anchors.right: parent.right
	}
}