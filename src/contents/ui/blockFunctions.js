function getType(t = setText){
	parseResult =  Parser.parseMarkdownLine(t)
	text = parseResult.plainText
	if(parseResult.isChecklist){
		type = Block.Type.CheckList
		checked = parseResult.isChecked
		return
	} else if(parseResult.isDotList){
		type = Block.Type.DotList
		return
	} else if(parseResult.isQuote){
		type = Block.Type.Quote
		return
	} else if(parseResult.isCodeBlock){
		type = Block.Type.CodeBlock
		return
	} else if(parseResult.isHeader){
		headerNum = parseResult.headerNumber
		return
	}

	type = Block.Type.PlainText;
}

function newBlock(set_text=""){
	blockModel.insert(index+1, {set_text: set_text, set_type: newType()}) // TODO set type
	down()
}

function newType(){
	if (type == Block.Type.CheckList || type == Block.Type.DotList || type == Block.Type.Quote){
		// copy formatting
		return type
	} else {
		// use PlainText
		return Block.Type.PlainText
	}
}

function setCursorPosition(pos){
	if(pos === -1){
		txt.cursorPosition = txt.length
	} else if (pos < txt.length){
		txt.cursorPosition = pos
	} else {
		txt.cursorPosition = txt.length
	}
}

function forceFocus(){
	txt.forceActiveFocus()
	console.warn("forced focus on active object")
}

function up(){
	if(index > 0){
		document.currentIndex = index-1
		document.currentItem.setCursorPosition(calculateNextCursorPosition())
	}
}

function down(){
	if(index + 1 < document.count){
		document.currentIndex = index + 1
		document.currentItem.setCursorPosition(calculateNextCursorPosition())
	}
}

function calculateNextCursorPosition(){
	let cursor_index = txt.cursorPosition
	if(txt.cursorPosition == txt.length){
		cursor_index = -1
	} else if(txt.cursorPosition == 0){
		cursor_index = 0
	}
	return cursor_index
}

function mergeBlocks(i1, i2){ // b1 is removed and attached to b2 (i is the index)
	let extext = document.itemAtIndex(i2).text.replace(/\n\n$/g, "") // TODO remove problem at the source (parser probably) (no, probably it's more difficult)
	let pos = document.itemAtIndex(i2).length
	document.itemAtIndex(i2).text = extext + document.itemAtIndex(i1).text.replace(/\n\n$/g, "")
	document.itemAtIndex(i2).forceFocus()
	document.itemAtIndex(i2).setCursorPosition(pos)
	
	document.remove(i1)
}

function textSize(){
	let x = [34, 26, 23, 20, 18, 17]
	let n = headerNum - 1
	if(n < 0){
		return 15
	}

	let ret = x[n]
	if(ret == undefined){
		return x[x.length-1]
	}

	return ret
}