import QtQuick 2.15
import QtQuick.Controls 2.5

Item{
	visible: false
	function copy(str){
		clip.text = str
		clip.selectAll()
		clip.copy()
	}

	function paste(){
		clip.text = ""
		clip.paste()
		return clip.text
	}
	TextEdit{
		id: clip
		visible: false

	}
}