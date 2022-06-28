# TunaNotes

[description]

## TODOs:
+ [x] set text size in config
+ [x] when clicked outside the scrollview, give focus to the last block and move cursor to the end
+ [x] export to .md and get data at startup
+ [ ] paste multiline 
+ [ ] select multiline (difficult)
+ [x] custom icon in config, if empty use default (`Plasmoid.icon`)
+ [x] added plasma theme colors setting
+ [x] convert --- (or more) in horizontal line
+ [x] make checkboxes clickable (perhaps using real checkboxes)
+ [x] perhaps is better to manually convert to markdown view using html
    + [[spacer] [vertical_line] [thickbox] [text]] [markdown]
    + hide everytime elements not used
    + the spacer's width depends on the number of `\t` at the beginning of the text
        + at import, convert 2+ spaces in tabs (medium difficult)
+ [x] make right/left arrows navigate up/down when at beginning or end of line
+ [ ] make up/down arrows keep the cursor position in all blocks (or always use the bottom?)
+ [x] triple click to select all line
+ [x] tab in any part of the text does nothing if not a list, or move list
+ [x] duplicates the formatting in the following block when created
* [ ] reduce tab char size (difficult)
* [ ] ctl+Z for multiple lines?
* [ ] make different bullets depending on the indent
* [x] added `` `code` `` format
* [ ] enter mid-line breaks in half the block
* [ ] make a better config page with color picker