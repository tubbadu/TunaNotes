import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami
import org.kde.syntaxhighlighting 1.0

Item{
	property int tabSize: 20
	property int tabNum: 0
	height: 1
	Layout.preferredWidth: (tabSize * tabNum) + 2
}