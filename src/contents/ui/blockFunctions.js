function getType(t = setText){
	if(parseResult == undefined){
		parseResult =  Parser.parseMarkdownLine(t)
	}
	text = parseResult.plainText
	syntaxHighlightning = parseResult.syntaxHighlightning
	tabNum = parseResult.numTabs

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

function newBlock(set_text="", set_tabnum=0, set_headernum=0){
	//blockModel.insert(index+1, {set_text: set_text, set_type: newType(), set_tabnum: set_tabnum, set_headernum: set_headernum}) // TODO set type
	document.insertBlock({index: index+1, new_text: set_text, new_type: newType(), new_tabnum: set_tabnum, new_headernum: set_headernum})
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

function sync(){
	// saves modifications to the model so that the buffer does not creates any problem
	blockModel.set(index, {set_text: text, set_type: type, set_tabnum: tabNum, set_headernum: headerNum, set_syntaxhighlightning: syntaxHighlightning})
}

function getLinksCoordinates(text){
	const regex = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})/g;
	const linkIndices = [];
	let match;

	while ((match = regex.exec(text)) !== null) {
		const start = match.index;
		const end = match.index + match[0].length;
		var link = match[0];
		if(!link.startsWith("http")){
			link = "http://" + link
		}
		linkIndices.push([start, end, link]);
	}

	return(linkIndices);
}

function linkAtIndex(linksCoordinates, i){
	let ret = "";
	linksCoordinates.forEach(linkCoordinates => {
		if(linkCoordinates[0] < i && i < linkCoordinates[1]){
			ret = linkCoordinates[2]
		}
	});
	return ret;
}