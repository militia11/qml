import QtQuick 2.0

PathView {
    id: root
    width: 200;  height: 800
    delegate: buttonsViewDelegate
    model: effectsNames
    focus: true
    property bool effectButtonOnPath: true
    property string keyButton: ""

    path: Path {
        startX: root.width/2
        startY: 0
        PathAttribute { name: "itemZ"; value: 0 }
        PathAttribute { name: "itemAngle"; value: -90.0; }
        PathAttribute { name: "itemScale"; value: 0.5; }
        PathLine { x: root.width/2; y: root.height*0.4; }
        PathPercent { value: 0.48; }
        PathLine { x: root.width/2; y: root.height*0.5; }
        PathAttribute { name: "itemAngle"; value: 0.0; }
        PathAttribute { name: "itemScale"; value: 1.0; }
        PathAttribute { name: "itemZ"; value: 100 }
        PathLine { x: root.width/2; y: root.height*0.6; }
        PathPercent { value: 0.52; }
        PathLine { x: root.width/2; y: root.height; }
        PathAttribute { name: "itemAngle"; value: 90.0; }
        PathAttribute { name: "itemScale"; value: 0.5; }
        PathAttribute { name: "itemZ"; value: 0 }
    }

    pathItemCount: 16
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5

    onMovementStarted: {
        root.deactivateEffectsButton()
        tools.activateTipTool()
        timers.startScroll()
        tools.visible = true
        if (mainButtons.state == "expanded") {
           mainButtons.state = "slim"
        }
    }

    onMovementEnded: {
        timers.disabledScrollPathView()
        tools.switchActiveToolbars(root.currentItem.text)
        effects.switchActiveEffect(root.currentItem.text)
    }

    Keys.onUpPressed: {
        incrementCurrentIndex()
        root.deactivateEffectsButton()
        tools.visible = true
        var i = root.currentIndex
        keyButton = effectsNames.get(++i).name
        tools.switchActiveToolbars(keyButton)
    }

    Keys.onDownPressed: {
        decrementCurrentIndex()
        root.deactivateEffectsButton()
        tools.visible = true
        var i = root.currentIndex
        keyButton = effectsNames.get(--i).name
        tools.switchActiveToolbars(keyButton)
    }

    Keys.onReleased: {
        effects.switchActiveEffect(keyButton)
    }

    function deactivateEffectsButton() {
        if(effectButtonOnPath) {
            effectsNames.remove(0)
            effectButtonOnPath = false
        }
    }

    function activateEffectsButton() {
        if(root.currentIndex !=0 ) {
            effectsNames.insert(0, { name: "EFFECTS"} )
            root.positionViewAtIndex(0, PathView.Center)
            effects.switchActiveEffect("EFFECTS")
            effectButtonOnPath = true
        }
    }

    function activateScroll() {
        tools.printToolTip(root.currentItem.text)
    }
}
