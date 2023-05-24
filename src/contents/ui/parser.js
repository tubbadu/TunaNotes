function tabCounter(line){
	// Replace 4 spaces with a tab
	line = line.replace(/    /g, '\t');

	// Count the number of tabs at the beginning of the line
	let numTabs = (line.match(/^\t/g) || []).length;

	return numTabs;
}

function getPlainText(line){
	const headerRegex = /^#+\s/;
	const checklistRegex = /^- \[( |x)\]/;
	const dotListRegex = /^([-*+])\s/;
	const quoteRegex = /^>\s/;
	const codeBlockRegexEnd = /```+/;
	const codeBlockRegexStart = /^```/;

	const plainText = line.trim()
		.replace(headerRegex, '')
		.replace(checklistRegex, '')
		.replace(dotListRegex, '')
		.replace(quoteRegex, '')
		.replace(codeBlockRegexStart, '')
		.replace(codeBlockRegexEnd, '');
	return plainText.trim()
}

function getSyntaxHighlightning(line){
	const regex = /```(.+)\n/g;
	const matches = regex.exec(line);
	if (matches && !matches[1].includes(" ")) {
		return matches[1];
	}
	return 'text';
}

function parseMarkdownLine(line) {
	// Define regular expressions for each type of formatting
	const headerRegex = /^#+\s(.*)/;
	const checklistRegex = /^- \[( |x)\](.*)/;
	const dotListRegex = /^([-*+])\s(.*)/;
	const quoteRegex = /^>\s(.*)/;
	//const tableRegex = /^\|(.*)\|$/;
	const codeBlockRegex = /^```(.*)/;

	
	const syntaxHighlightning = getSyntaxHighlightning(line)
	let plainText = getPlainText(line).replace(syntaxHighlightning, "").trim()

	let isChecklist = false;
	let isChecked = false;
	let isHeader = false;
	let headerNumber = 0;
	let isDotList = false;
	let isQuote = false;
	let isTable = false;
	let isCodeBlock = false;
	let numTabs = tabCounter(line);
	let rawText = line;

	// remove initial tabs and spaces
	line = line.trim()

	if(line.trim() == "<br>"){
		plainText = ""
	} else if (checklistRegex.test(line)) {
		isChecklist = true;
		isChecked = line[3] === "x";
	} else if (dotListRegex.test(line)) {
		isDotList = true;
	} else if (headerRegex.test(line)) {
		isHeader = true;
		headerNumber = line.match(/^#+/)[0].length;
	} else if (quoteRegex.test(line)) {
		isQuote = true;
//	} else if (tableRegex.test(line)) {
//		isTable = true;
	} else if (codeBlockRegex.test(line)) {
		isCodeBlock = true;
	}

	return {
		rawText: rawText,
		plainText: plainText,
		isChecklist: isChecklist,
		isChecked: isChecked,
		isHeader: isHeader,
		headerNumber: headerNumber,
		isDotList: isDotList,
		isQuote: isQuote,
		//isTable: isTable,
		isCodeBlock: isCodeBlock,
		numTabs: numTabs,
		syntaxHighlightning: syntaxHighlightning
	};
}

function splitStringExceptInCodeBlocks(str) {
	const codeBlockPattern = /```[\s\S]*?```/g; // pattern for triple backtick code blocks
	const lineBreakReplacement = "<LB>"; // a special string to replace line breaks inside code blocks

	// replace line breaks inside code blocks with the special string
	const strWithReplacedLineBreaks = str.replace(codeBlockPattern, (match) => {
		return match.replace(/\n/g, lineBreakReplacement);
	});

	// split the string at line breaks outside of code blocks
	const lines = strWithReplacedLineBreaks.split(/\n+/);

	// restore the line breaks inside code blocks
	for (let i = 0; i < lines.length; i++) {
		lines[i] = lines[i].replace(new RegExp(lineBreakReplacement, "g"), "\n");
	}

	return lines;
}

function exportMarkdown(interval = document.noSelection){
	let doc = ""
	for(let i=0; i<blockModel.count; i++){
		let blk = blockModel.get(i)
		if(blk && blk){ //interval == document.noSelection || (interval[0] <= i && i <= interval[1])){
			console.warn(">>", blk.data)
			let x = blk.set_tabnum > 0? blk.set_tabnum : 0
			let line = "\t".repeat(x)

			if(blk.set_type == Block.Type.PlainText){
				// do nothing
			}else if(blk.set_type == Block.Type.Quote){
				line += "> "
			}else if(blk.set_type == Block.Type.DotList){
				line += "- "
			}else if(blk.set_type == Block.Type.CheckList){
				if(blk.set_typechecked){
					line += "- [x] "
				}else{
					line += "- [ ] "
				}
			}else if(blk.set_type == Block.Type.CodeBlock){
				line += "```" + blk.set_syntaxhighlightning + "\n" // how can this work? I have no idea...
			}

			line += "#".repeat(blk.set_headernum) + " ".repeat(blk.set_headernum > 0)

			line += blk.set_text

			if(blk.set_type == Block.Type.CodeBlock){
				line += "\n```"
			}
			if(blk.set_text < 1){
				line = "<br>"
			}
			if(doc.length > 0) {
				doc += "\n\n"
			}
			doc += line
		}
	}
	return doc;
}
