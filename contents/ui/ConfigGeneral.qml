import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
	id: page

	property alias cfg_filePath: filePath.text
	property alias cfg_fullHeight: fullHeight.value
	property alias cfg_fullWidth: fullWidth.value
	property alias cfg_textColor: textColor.text
	property alias cfg_textBackground: textBackground.text
	property alias cfg_textSelectionBackground: textSelectionBackground.text
	property alias cfg_activeBlockBackground: activeBlockBackground.text
	property alias cfg_textSize: textSize.value
	property alias cfg_customIcon: customIcon.text
	property alias cfg_useDefault: useDefault.checked //(useDefault.checkState === Qt.Checked)


	///////////////////////////
	RowLayout {
		id: setSize
		spacing: 6
		Label{
			text: i18n("Height:")
		}
		SpinBox {
			id: fullHeight
			from: 1
			to: 5000
		}
	}
	RowLayout{
		Label{
			text: i18n("Width:")
		}
		SpinBox {
			id: fullWidth
			from: 1
			to: 5000
		}
	}
	RowLayout{
		Label{
			text: i18n("Font size (px):")
		}
		SpinBox {
			id: textSize
			from: 1
			to: 200
		}
	}
	TextField {
		id: customIcon
		Kirigami.FormData.label: i18n("Custom icon (name or full path):")
	}
	TextField {
		id: filePath
		Kirigami.FormData.label: i18n("markdown file path:")
	}
	CheckBox{
		id: useDefault
		Kirigami.FormData.label: i18n("Use plasma theme default colors:")
	}
	TextField {
		id: textColor
		enabled: !useDefault.checked //(useDefault.checkState === Qt.Checked)
		Kirigami.FormData.label: i18n("Text color:")
		onFocusChanged: {
			if (focus){
				//colorPicker.color = text
				//colorPicker.open()
				
			}
		}
	}
	
	TextField {
		id: textBackground
		enabled: !(useDefault.checkState === Qt.Checked)
		Kirigami.FormData.label: i18n("Text background color:")
	}
	TextField {
		id: textSelectionBackground
		enabled: !(useDefault.checkState === Qt.Checked)
		Kirigami.FormData.label: i18n("Text selection highlight color:")
	}
	TextField {
		id: activeBlockBackground
		enabled: !(useDefault.checkState === Qt.Checked)
		Kirigami.FormData.label: i18n("Active block background color:")
	}
	
}
