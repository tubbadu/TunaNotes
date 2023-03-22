function tabCounter(line){
	// Replace 4 spaces with a tab
	line = line.replace(/    /g, '\t');

	// Count the number of tabs
	let numTabs = (line.match(/\t/g) || []).length;

	return numTabs;
}

function getPlainText(line){
	const headerRegex = /^#+\s/;
	const checklistRegex = /^- \[( |x)\]/;
	const dotListRegex = /^([-*+])\s/;
	const quoteRegex = /^>\s/;
	const codeBlockRegex = /^```+|```+$/;

	const plainText = line.trim()
		//.replace(headerRegex, '')
		.replace(checklistRegex, '')
		.replace(dotListRegex, '')
		.replace(quoteRegex, '')
		.replace(codeBlockRegex, '');
	return plainText.trim()
}

function parseMarkdownLine(line) {
	// Define regular expressions for each type of formatting
	const headerRegex = /^#+\s(.*)/;
	const checklistRegex = /^- \[( |x)\](.*)/;
	const dotListRegex = /^([-*+])\s(.*)/;
	const quoteRegex = /^>\s(.*)/;
	//const tableRegex = /^\|(.*)\|$/;
	const codeBlockRegex = /^```(.*)/;

	const plainText = getPlainText(line)

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

	if (checklistRegex.test(line)) {
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
		numTabs: numTabs
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