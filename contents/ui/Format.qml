import QtQuick 2.7
import org.kde.plasma.plasmoid 2.0

Rectangle {

	property string textColor: Plasmoid.configuration.textColor
	property string textBackground: Plasmoid.configuration.textBackground

	function format(txt){
		let formatted = txt
		let isCheckbox = false
		let isChecked = false
		let isBullet = false
		let isQuote = false
		let isDivider = false
		let dividerDouble = false
		let titleNum = 0
		let spacerNum = 0

		let x = null

		////////////////////////////////////


		// check for titles
		x = txt.trim().match(/^#+ /g)
		if (x != null){
			// is a title
			titleNum = x[0].trim().length
			if (titleNum > 0 && titleNum < 6){
				// is good
				formatted = "<h" + titleNum + ">" + txt.trim().replace(/^#+ /g, "") + "</h" + titleNum + ">"
			} else{
				formatted = txt //it's a user error
			}
		}

		// check for initial tabs (\t)
		x = txt.match(/^\t+/g)
		if (x != null){
			// is a title
			let tabNum = x[0].trim().length
			spacerNum = 2//spacerNum + tabNum
		}

		// check for quotes
		x = txt.trim().match(/^> /g)
		if (x != null){
			// is a quote
			// I will not support nested blockquotes or other things inside till now
			isQuote = true
			spacerNum++
			formatted = txt.trim().replace(/^> /g, "")
		}

		// check for unordered list
		x = txt.trim().match(/^(\+|\-|\*) /g)
		if (x != null){
			// check for checkbox list
			x = txt.trim().match(/^(\+|\-|\*) \[( |x|X)\]/g)
			if (x != null){
				// is checkbox list
				isCheckbox = true
				x = txt.trim().match(/^(\+|\-|\*) \[( )\]/g)
				if (x != null){
					// not checked
					isChecked = false
				} else {
					//checked
					isChecked = true
				}
				formatted = txt.trim().replace(/^(\+|\-|\*) \[( |x)\]/g, "")
			} else {
				// is bullet list
				isBullet = true
				formatted = txt.trim().replace(/^(\+|\-|\*) /g, "")
			}
			spacerNum++
		}
		// TODO check for ordered list

		// check for horizontal divider
		x = txt.trim().match(/^(\+|\-|\*){3,}/g)
		if (x != null) {
			//is divider
			formatted = "<hr>" //doesn't work
			isDivider = true
			dividerDouble = false
		}

		// check for double horizontal divider
		x = txt.trim().match(/^(\=){3,}/g)
		if (x != null) {
			//is divider
			formatted = "<hr>" //doesn't work
			isDivider = true
			dividerDouble = true
		}

 		// check for bold in formatted
		formatted = formatted.replace(/\*\*(.*?)\*\*/gm, "<strong>$1</strong>"); //formatted.match(/\*\*.+\*\*/g)
		// check for italic in formatted
		formatted = formatted.replace(/\*(.*?)\*/gm, "<i>$1</i>"); //formatted.match(/\*\*.+\*\*/g)
		// check for inline code
		formatted = formatted.replace(/\`(.*?)\`/gm, "<font color='" + textBackground + "'><code style='background-color: " + textColor + "'>$1</code></font>")

		return {
			"formatted": formatted,
			"isCheckbox": isCheckbox,
			"isChecked": isChecked,
			"isBullet": isBullet,
			"spacerNum": spacerNum,
			"isQuote": isQuote,
			"isDivider": isDivider,
			"dividerDouble": dividerDouble,
			"titleNum": titleNum
		};
	}
}
