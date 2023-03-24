function key(event){
	var key = event.key
	if (key == Qt.Key_Enter || key == Qt.Key_Return) {
		enableTextFormat = false
		console.warn("enter");
		event.accepted = true;
		let subtext = text.substr(cursorPosition, text.length)
		text = text.substr(0, cursorPosition)
		newBlock(subtext);
		enableTextFormat = false
	} else if (key == Qt.Key_Down) {
		event.accepted = true;
		down();
	} else if (key == Qt.Key_Up) {
		event.accepted = true;
		up();
	} else if (key == Qt.Key_Delete) {
		if(cursorPosition == txt.length && index < document.count-1){
			event.accepted = true;
			console.warn("marging this block to the previous one");
			mergeBlocks(index+1, index)
		}
	} else if (key == Qt.Key_Backspace) {
		console.warn("type: " + type)
		console.warn("cursorPosition: " + cursorPosition)
		console.warn("headerNum: " + headerNum)
		if(cursorPosition == 0){
			event.accepted = true;
			if ((type != Block.Type.CodeBlock) && (headerNum > 0)){
				headerNum--
			}else if(type !== Block.Type.PlainText){
				type = Block.Type.PlainText
				console.warn("removing formatting");
			} else if(index > 0){
				console.warn("marging this block to the previous one");
				mergeBlocks(index, index-1)
			}
		}
	} else if(key == Qt.Key_Tab) {
		// todo add codeblock support
		event.accepted = true;
		tabNum++
	} else if(key == Qt.Key_Backtab) {
		// todo add codeblock support
		event.accepted = true;
		if(tabNum > 0){
			tabNum--
		}
	} else if(key == Qt.Key_NumberSign && cursorPosition == 0){
		if(type == Block.Type.PlainText || true){
			event.accepted = true;
			if(headerNum < 6){
				headerNum++
			}
		}
	} else if(key == Qt.Key_Greater && cursorPosition == 0){
		// ignore the current formatting, just set it to quote or plaintext
		if(type == Block.Type.Quote){
			type = Block.Type.PlainText
		} else {
			type = Block.Type.Quote
		}
		event.accepted = true
	} else if((key == Qt.Key_Minus || key == Qt.Key_Plus || key == Qt.Key_Asterisk) && cursorPosition == 0){
		// ignore the current formatting, just set it to quote or plaintext
		if(type == Block.Type.DotList){
			type = Block.Type.PlainText
		} else {
			type = Block.Type.DotList
		}
		event.accepted = true
	} else if(key == Qt.Key_BracketRight && cursorPosition == 1 && text[0] == "["){
		// ignore the current formatting, just set it to quote or plaintext
		type = Block.Type.CheckList
		text = text.replace(/^\[/, "")
		event.accepted = true
	} else if(key == Qt.Key_Space){
		// parse
		if(type == Block.Type.PlainText && headerNum == 0){
			let extext = text
			getType(text.slice(0, cursorPosition) + " " + text.slice(cursorPosition))
			if(text != extext){
				event.accepted = true
			}
		}
	} else if(key == Qt.Key_Left){
		if(cursorPosition == 0 && index > 0){
			document.currentIndex--
			document.currentItem.setCursorPosition(-1)
			event.accepted = true
		}
	} else if(key == Qt.Key_Right){
		if(cursorPosition == txt.length && index < document.count-1){
			document.currentIndex++
			document.currentItem.setCursorPosition(0)
			event.accepted = true
		}
	}
}
