function key(event){
	var key = event.key
	var modifiers = event.modifiers

	if(modifiers == Qt.ShiftModifier && key == Qt.Key_Up){
		// Shift+Up
		shiftUp(event)
		return
	} else if(modifiers == Qt.ShiftModifier && key == Qt.Key_Down){
		// Shift+Down
		shiftDown(event)
		return
	} else if (modifiers == Qt.ControlModifier && key == Qt.Key_C && !nothingSelected) {
		// Ctrl+C
		copySelected(event)
	} else if (modifiers == Qt.ControlModifier && key == Qt.Key_V) {
		// Cltr+V
		paste(event)
	} else if (modifiers == Qt.ControlModifier && key == Qt.Key_X && !nothingSelected) {
		// Ctrl+X
		copySelected(event)
		deleteSelected()
	}  else if ((key == Qt.Key_Enter || key == Qt.Key_Return) && type != Block.Type.CodeBlock) {
		enterPressed(event)
		unselectSelected()
	} else if (key == Qt.Key_Down) {
		if(cursorPosition == length && index == document.count-1){
			newBlock()
			accept(event)
			unselectSelected()
		}else if(type != Block.Type.CodeBlock){
			accept(event)
			down();
			unselectSelected()
		}		
	} else if (key == Qt.Key_Up && type != Block.Type.CodeBlock) {
		accept(event)
		up();
		unselectSelected()
	} else if (key == Qt.Key_Delete) {
		delPressed(event)
	} else if (key == Qt.Key_Backspace) {
		backspacePressed(event)
	} else if(key == Qt.Key_Tab) {
		tabPressed(event)
	} else if(key == Qt.Key_Backtab) {
		backtabPressed(event)
	} else if(key == Qt.Key_NumberSign){
		hashtagPressed(event)
	} else if(key == Qt.Key_Greater){
		quotePressed(event)
	} else if((key == Qt.Key_Minus || key == Qt.Key_Plus || key == Qt.Key_Asterisk)){
		dotPressed(event)
	} else if(key == Qt.Key_BracketRight){
		closeBracketPressed(event)
	} else if(key == Qt.Key_BracketLeft){
		openBracketPressed(event)
	} else if(key == Qt.Key_BraceLeft || key == Qt.Key_BraceRight){
		bracePressed(event)
	} else if(key == Qt.Key_ParenLeft || key == Qt.Key_ParenRight){
		parenthesisPressed(event)
	} else if(key == Qt.Key_Space){
		//spacePressed(event)
	} else if(key == Qt.Key_Left){
		leftPressed(event)
	} else if(key == Qt.Key_Right){
		rightPressed(event)
	} else if(key == Qt.Key_QuoteLeft){
		backtickPressed(event)
	} else if(key == Qt.Key_QuoteDbl){
		doublequotePressed(event)
	} else if(key == Qt.Key_Apostrophe){
		singlequotePressed(event)
	} else{
		//console.warn(key)
		//unselectSelected()
		//accept(event)
	}

	if(!nothingSelected){
		accept(event)
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

function shiftUp(event){
	accept(event)
	if(document.nothingSelected){
		document.selection.blockStart = index
		document.selection.blockEnd = index
		document.selection.refresh()
	} else if (document.selection.blockEnd == index){
		document.selection.blockStart = document.selection.blockStart - 1
		document.selection.blockEnd = document.selection.blockEnd
		document.selection.refresh()
	} else {
		document.selection.blockStart = document.selection.blockStart
		document.selection.blockEnd = document.selection.blockEnd - 1
		document.selection.refresh()
	}

	if(document.selection.blockStart < 0){
		document.selection.blockStart = 0
		document.selection.refresh()
	}
}

function shiftDown(event){
	accept(event)
	console.warn("start:", JSON.stringify(document.selection), JSON.stringify(document.noSelection), document.nothingSelected)
	if(document.nothingSelected){
		console.warn("caso 1:")
		document.selection.blockStart = index
		document.selection.blockEnd = index
		document.selection.refresh()
	} else if (document.selection.blockStart == index){
		console.warn("caso 2")
		document.selection.blockStart = document.selection.blockStart
		document.selection.blockEnd = document.selection.blockEnd + 1
		document.selection.refresh()
	} else {
		console.warn("caso 3:")
		document.selection.blockStart = document.selection.blockStart + 1
		document.selection.blockEnd = document.selection.blockEnd
		document.selection.refresh()
	}
	if(document.selection.blockEnd > document.count-1){
		console.warn("caso 4")
		document.selection.blockEnd = document.count-1
	}
}

function copySelected(event){
	accept(event)
	let sel = Parser.exportMarkdown(document.selection)
	clipboard.copy(sel)
}

function unselectSelected(){
	document.unselectAll()
}

function paste(event){
	let clip = clipboard.paste()
	if(clip.includes("\n")){
		let clipLines = clip.split("\n")

		if(text.trim().length == 0){
			// first pasted line, the original block is empty:
			// do not create a new block
		} else if(cursorPosition == 0){
			// insert blocks before current block:
			//blockModel.insert(index, {set_text: "", set_type: Block.Type.PlainText, set_tabnum: 0, set_headernum: 0})
			document.insertBlock({index: index})
			currentIndex = index-1
		}
		pasteParsed(clipLines[0], currentItem)

		for(let i=0; i<clipLines.length; i++){ // skip first element, already done
			if(clipLines[i].trim().length > 0){
				if(i != clipLines.length-1) {
					//blockModel.insert(currentIndex+1, {set_text: "", set_type: Block.Type.PlainText, set_tabnum: 0, set_headernum: 0})
					document.insertBlock({index: currentIndex+1})
				}
				pasteParsed(clipLines[i], currentItem)
				currentIndex++
			}
		}
		accept(event)
	} else if(text.trim().length == 0){
		pasteParsed(clip)
		accept(event)
	}
}

function pasteParsed(text, blk=block){
	blk.parseResult = undefined
	blk.getType(text)
	blk.setCursorPosition(-1)
}

function deleteSelected(event){
	accept(event)
	for(let i=count-1; i>=0; i--){ // at reverse so removing elements does not cause selected elements to change
		if(document.itemAtIndex(i).selected){
			document.remove(i)
		}
	}
	document.unsaved = true
}

function indentSelected(event, n){
	accept(event)
	for(let i=count-1; i>=0; i--){ // at reverse so removing elements does not cause selected elements to change
		if(document.itemAtIndex(i).selected){
			let newTabNum = document.itemAtIndex(i).tabNum + n
			if(newTabNum >= 0){
				document.itemAtIndex(i).tabNum = newTabNum
			}
		}
	}
}

function setTypeToSelected(event, t){ // not used
	accept(event)
	for(let i=count-1; i>=0; i--){ // at reverse so removing elements does not cause selected elements to change
		if(document.itemAtIndex(i).selected){
			document.itemAtIndex(i).type = t
		}
	}
}

function backspacePressed(event){
	if(document.nothingSelected){
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
					document.unsaved = true;
				}
				accept(event)
			}
		}
	} else {
		deleteSelected(event)
	}
}

function delPressed(event){
	if(document.nothingSelected){
		if(selectedText.length == 0){
			if(text.length == 0){
				document.remove(index)
				currentItem.setCursorPosition(0)
				accept(event)
				document.unsaved = true;
			} else if(cursorPosition == txt.length && index < document.count-1){
				accept(event)
				mergeBlocks(index+1, index)
				document.unsaved = true;
			}
		}
	} else {
		deleteSelected(event)
	}
}

function tabPressed(event){
	if(document.nothingSelected){
		if(type != Block.Type.CodeBlock){
			accept(event)
			tabNum++
		}
	} else {
		indentSelected(event, +1)
	}
}

function backtabPressed(event){
	if(document.nothingSelected){
		if(type != Block.Type.CodeBlock){
			accept(event)
		if(tabNum > 0){
			tabNum--
		}
		}
	} else {
		indentSelected(event, -1)
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
	if(selectedText.length > 0){
		applyToHighlight("\`", "\`")
		accept(event)
	}else if(cursorPosition == 0){
		if(type == Block.Type.CodeBlock){
			type = Block.Type.PlainText
		} else {
			type = Block.Type.CodeBlock
			headerNum = 0
		}
		accept(event)
	}
}

function doublequotePressed(event){
	if(selectedText.length > 0){
		applyToHighlight("\"", "\"")
		accept(event)
	}
}

function singlequotePressed(event){
	if(selectedText.length > 0){
		applyToHighlight("\'", "\'")
		accept(event)
	}
}

function applyToHighlight(firstStr, lastStr){
	let pos = selectionEnd + 2
	text = [text.slice(0, selectionStart), firstStr, text.slice(selectionStart, selectionEnd), lastStr, text.slice(selectionEnd)].join('')
	cursorPosition = pos
}

function hashtagPressed(event){
	if(document.nothingSelected){
		if(cursorPosition == 0){
			accept(event)
			if(headerNum < 6){
				headerNum++
			}
		}
	} else {

	}
}

function quotePressed(event){
	if(cursorPosition == 0){
		// ignore the current formatting, just set it to quote or plaintext
		if(type == Block.Type.Quote){
			type = Block.Type.PlainText
		} else {
			type = Block.Type.Quote
		}
		accept(event)
	}
}

function dotPressed(event){
	if(cursorPosition == 0){
		// ignore the current formatting, just set it to quote or plaintext
		if(type == Block.Type.DotList){
			type = Block.Type.PlainText
		} else {
			type = Block.Type.DotList
		}
		accept(event)
	}
}

function closeBracketPressed(event){
	let reg = /^\s*\[/
	if(selectedText.length > 0){
		applyToHighlight("[", "]")
		accept(event)
	} else if(reg.test(text) && cursorPosition == text.indexOf("[") + 1){
		
		accept(event)
		text = text.replace(reg, "")
		type = Block.Type.CheckList
	}
}
function openBracketPressed(event){
	if(selectedText.length > 0){
		applyToHighlight("[", "]")
		accept(event)
	}
}

function bracePressed(event){
	if(selectedText.length > 0){
		applyToHighlight("{", "}")
		accept(event)
	}
}

function parenthesisPressed(event){
	if(selectedText.length > 0){
		applyToHighlight("(", ")")
		accept(event)
	}
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
	} else if(cursorPosition == 0){
		// keep formatting of this block, and add a block before
		//blockModel.insert(index, {set_text: "", set_type: Block.Type.PlainText, set_tabnum: 0, set_headernum: 0})
		document.insertBlock({index: index})
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
