function key(event){
	var key = event.key
	var modifiers = event.modifiers

	if(modifiers == Qt.ShiftModifier && key == Qt.Key_Up){
		// Shift+Up
		accept(event)
		if(document.selection === document.noSelection){
			document.selection = [index, index]
		} else if (document.selection[1] == index){
			document.selection = [document.selection[0] - 1, document.selection[1]]
		} else {
			document.selection = [document.selection[0], document.selection[1] - 1]
		}

		if(document.selection[0] < 0){
			document.selection[0] = 0
		}
		return
	} else if(modifiers == Qt.ShiftModifier && key == Qt.Key_Down){
		// Shift+Down
		accept(event)
		if(document.selection === document.noSelection){
			document.selection = [index, index]
		} else if (document.selection[0] == index){
			document.selection = [document.selection[0], document.selection[1] + 1]
		} else {
			document.selection = [document.selection[0] + 1, document.selection[1]]
		}
		if(document.selection[1] > document.count-1){
			document.selection[1] = document.count-1
		}
		return
	} else if(modifiers == Qt.NoModifier && key != Qt.Key_Backspace && key != Qt.Key_Delete){
		console.warn("unselecting")
		document.selection = document.noSelection
	}
	
	if (modifiers == Qt.ControlModifier && key == Qt.Key_C && document.selection != document.noSelection) {
		copySelected(event)
	} else if ((key == Qt.Key_Enter || key == Qt.Key_Return) && type != Block.Type.CodeBlock) {
		enterPressed(event)
	} else if (key == Qt.Key_Down) {
		if(cursorPosition == length && index == document.count-1){
			newBlock()
			accept(event)
		}else if(type != Block.Type.CodeBlock){
			accept(event)
			down();
		}		
	} else if (key == Qt.Key_Up && type != Block.Type.CodeBlock) {
		accept(event)
		up();
	} else if (key == Qt.Key_Delete && selectedText.length == 0) {
		delPressed(event)
	} else if (key == Qt.Key_Backspace) {
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
		//spacePressed(event)
	} else if(key == Qt.Key_Left){
		leftPressed(event)
	} else if(key == Qt.Key_Right){
		rightPressed(event)
	} else if(key == Qt.Key_QuoteLeft && cursorPosition == 0){
		backtickPressed(event)
	}
}

function globalKey(event){
	// strange behavior: gets triggered three times
	var key = event.key
	var modifiers = event.modifiers
	if(modifiers == Qt.ControlModifier && key == Qt.Key_S){
		// Ctrl+S
		document.save()
	} else if(modifiers == Qt.AltModifier && key == Qt.Key_Backspace){
		// Ctrl+Backspace
		removeFormatting()
	}
}

function copySelected(event){
	accept(event)
	let sel = Parser.exportMarkdown(document.selection)
	console.warn(sel)
	clipboard.copy(sel)
}

function backspacePressed(event){
	if(document.selection === document.noSelection){
		if(selectedText.length == 0){
			if(cursorPosition == 0){
				if ((type != Block.Type.CodeBlock) && (headerNum > 0)){
					headerNum--
				}else if(type !== Block.Type.PlainText){
					type = Block.Type.PlainText
					console.warn("removing formatting");
				} else if(tabNum > 0){
					tabNum--
				} else if(index > 0){
					mergeBlocks(index, index-1)
				}
				accept(event)
			}
		}
	} else {
		accept(event)
		for(let i=count-1; i>=0; i--){ // at reverse so removing elements does not cause selected elements to change
			if(document.itemAtIndex(i).selected){
				document.remove(i)
			}
		}
	}
}

function delPressed(event){
	if(document.selection === document.noSelection){
		if(selectedText.length == 0){
			if(cursorPosition == txt.length && index < document.count-1){
				accept(event)
				mergeBlocks(index+1, index)
			}
		}
	} else {
		accept(event)
		for(let i=count-1; i>=0; i--){ // at reverse so removing elements does not cause selected elements to change
			if(document.itemAtIndex(i).selected){
				document.remove(i)
			}
		}
	}
}

function tabPressed(event){
	// todo add codeblock support
	accept(event)
	tabNum++
}

function backtabPressed(event){
	// todo add codeblock support
	accept(event)
	if(tabNum > 0){
		tabNum--
	}
}

function rightPressed(event){
	if(cursorPosition == txt.length && index < document.count-1){
		document.currentIndex++
		document.currentItem.setCursorPosition(0)
		accept(event)
	}
}

function leftPressed(event){
	if(cursorPosition == 0 && index > 0){
		document.currentIndex--
		document.currentItem.setCursorPosition(-1)
		accept(event)
	}
}

function backtickPressed(event){
	if(type == Block.Type.CodeBlock){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.CodeBlock
		headerNum = 0
	}
	accept(event)
}

function hashtagPressed(event){
	if(type == Block.Type.PlainText || true){
		accept(event)
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
	accept(event)
}

function dotPressed(event){
// ignore the current formatting, just set it to quote or plaintext
	if(type == Block.Type.DotList){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.DotList
	}
	accept(event)
}

function bracketPressed(event){
	// ignore the current formatting, just set it to quote or plaintext
	type = Block.Type.CheckList
	text = text.replace(/^\[/, "")
	accept(event)
}

function spacePressed(event){ // perhaps remove
	return
	// parse
	if(type == Block.Type.PlainText && headerNum == 0){
		let extext = text
		getType(text.slice(0, cursorPosition) + " " + text.slice(cursorPosition))
		if(text != extext){
			accept(event)
		}
	}
}

function enterPressed(event){
	accept(event)
	if(text.length < 1 && type != Block.Type.PlainText){
		// empty formatted text: remove formatting
		type = Block.Type.PlainText
	} else {
		let subtext = text.substr(cursorPosition, text.length)
		text = text.substr(0, cursorPosition)
		newBlock(subtext, tabNum);
	}
}

function removeFormatting(){
	document.currentItem.type = Block.Type.PlainText
	document.currentItem.headerNum = 0
	document.currentItem.tabNum = 0
}

function checkListToggle(){
	if(type == Block.Type.CheckList){
		type = Block.Type.PlainText
	} else {
		type = Block.Type.CheckList
	}
}

function accept(event){
	if(event) {if(event) {event.accepted = true;}}
}