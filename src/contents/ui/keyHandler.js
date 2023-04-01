function key(event){
	var key = event.key
	if ((key == Qt.Key_Enter || key == Qt.Key_Return) && type != Block.Type.CodeBlock) {
		enterPressed(event)
	} else if (key == Qt.Key_Down) {
		if(cursorPosition == length && index == document.count-1){
			newBlock()
			if(event) {event.accepted = true;}
		}else if(type != Block.Type.CodeBlock){
			if(event) {event.accepted = true;}
			down();
		}		
	} else if (key == Qt.Key_Up && type != Block.Type.CodeBlock) {
		if(event) {event.accepted = true;}
		up();
	} else if (key == Qt.Key_Delete && selectedText.length == 0) {
		delPressed(event)
	} else if (key == Qt.Key_Backspace && selectedText.length == 0) {
		backspacePressed(event)
	} else if(key == Qt.Key_Tab && type != Block.Type.CodeBlock) {
		tabPressed(event)
	} else if(key == Qt.Key_Backtab && type != Block.Type.CodeBlock) {
		backtabPressed(event)
	} else if(key == Qt.Key_NumberSign && cursorPosition == 0){
		hashtagPressed(event)
	} else if(key == Qt.Key_Greater && cursorPosition == 0){
		quotePressed(event)
	} else if((key == Qt.Key_Minus || key == Qt.Key_Plus || key == Qt.Key_Asterisk) && cursorPosition == 0){
		dotPressed(event)
	} else if(key == Qt.Key_BracketRight && cursorPosition == 1 && text[0] == "["){
		bracketPressed(event)
	} else if(key == Qt.Key_Space){
		spacePressed(event)
	} else if(key == Qt.Key_Left){
		leftPressed(event)
	} else if(key == Qt.Key_Right){
		rightPressed(event)
	} else if(key == Qt.Key_QuoteLeft&& cursorPosition == 0){
		backtickPressed(event)
	}
}

function globalKey(event){
	var key = event.key
	var modifiers = event.modifiers
	if(modifiers == Qt.ControlModifier && key == Qt.Key_S){
		// Ctrl+S
		document.save()
	}
}

function backspacePressed(event){
	if(cursorPosition == 0){
		if(event) {if(event) {event.accepted = true;}}
		if ((type != Block.Type.CodeBlock) && (headerNum > 0)){
			headerNum--
		}else if(type !== Block.Type.PlainText){
			type = Block.Type.PlainText
			console.warn("removing formatting");
		} else if(index > 0){
			mergeBlocks(index, index-1)
		}
	}
}

function delPressed(event){
	if(cursorPosition == txt.length && index < document.count-1){
		if(event) {event.accepted = true;}
		mergeBlocks(index+1, index)
	}
}

function tabPressed(event){
	// todo add codeblock support
	if(event) {event.accepted = true;}
	tabNum++
}

function backtabPressed(event){
	// todo add codeblock support
	if(event) {event.accepted = true;}
	if(tabNum > 0){
		tabNum--
	}
}

function rightPressed(event){
	if(cursorPosition == txt.length && index < document.count-1){
		document.currentIndex++
		document.currentItem.setCursorPosition(0)
		event.accepted = true
	}
}

function leftPressed(event){
	if(cursorPosition == 0 && index > 0){
		document.currentIndex--
		document.currentItem.setCursorPosition(-1)
		event.accepted = true
	}
}

function backtickPressed(event){
	if(type == Block.Type.CodeBlock){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.CodeBlock
	}
	if(event) {event.accepted = true;}
}

function hashtagPressed(event){
	if(type == Block.Type.PlainText || true){
		if(event) {event.accepted = true;}
		if(headerNum < 6){
			headerNum++
		}
	}
}

function quotePressed(event){
	// ignore the current formatting, just set it to quote or plaintext
	if(type == Block.Type.Quote){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.Quote
	}
	if(event) {event.accepted = true;}
}

function dotPressed(event){
// ignore the current formatting, just set it to quote or plaintext
	if(type == Block.Type.DotList){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.DotList
	}
	if(event) {event.accepted = true;}
}

function bracketPressed(event){
	// ignore the current formatting, just set it to quote or plaintext
	type = Block.Type.CheckList
	text = text.replace(/^\[/, "")
	if(event) {event.accepted = true;}
}

function spacePressed(event){ // perhaps remove
	return
	// parse
	if(type == Block.Type.PlainText && headerNum == 0){
		let extext = text
		getType(text.slice(0, cursorPosition) + " " + text.slice(cursorPosition))
		if(text != extext){
			if(event) {event.accepted = true;}
		}
	}
}

function enterPressed(event){
	if(event) {event.accepted = true;}
	if(text.length < 1 && type != Block.Type.PlainText){
		// empty formatted text: remove formatting
		type = Block.Type.PlainText
	} else {
		let subtext = text.substr(cursorPosition, text.length)
		text = text.substr(0, cursorPosition)
		newBlock(subtext);
	}
}

function removeFormatting(){
	if(type != Block.Type.PlainText){
		type = Block.Type.PlainText
	} else if(headerNum > 0){
		headerNum--
	}
}

function checkListToggle(){
	if(type == Block.Type.CheckList){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.CheckList
	}
}