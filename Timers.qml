import QtQuick 2.9

Item {
    Timer {
        id: timerRequestPaintAfterDelay
        interval: 40
        repeat: false
        running: false
        onTriggered: {
           canvas.requestPaint()
        }
    }

    Timer {
        id: timerScrollPathView
        interval: 40
        repeat: true
        running: false
        onTriggered: {
           pathViewButtons.activateScroll()
        }
    }

    function disabledScrollPathView() { timerScrollPathView.running = false}
    function startScroll(){ timerScrollPathView.start()}
    function requestPaintAfterDelay() { timerRequestPaintAfterDelay.start() }
}
