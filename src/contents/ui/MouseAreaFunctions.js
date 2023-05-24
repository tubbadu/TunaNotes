function singleClick(mouse){
    txt.startingSelection = -1
    if(isHoveringALink && (mouse.modifiers & Qt.ControlModifier)){
        Qt.openUrlExternally(hoveredLink)
    } else if (mouse.modifiers & Qt.ShiftModifier){
        if(document.currentIndex === index){

        }
    } else {

    }
    txt.forceActiveFocus()
}

function doubleClick(mouse){
    txt.forceActiveFocus()
    txt.cursorPosition = txt.positionAt(mouse.x, mouse.y)
    txt.selectWord()
    txt.startingSelection = -1
}
