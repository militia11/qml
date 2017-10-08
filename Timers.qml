import QtQuick 2.9

Item {
    Timer {
        id: timerPaintAfterEffectToImage
        interval: 40
        repeat: false
        running: false
        onTriggered: {
           canvas.requestPaint()
        }
    }

    Timer {
        id: tim
        interval: 90
        repeat: false
        running: false
        onTriggered: {
    //            canvas.width = sourceImage.width
    //            canvas.height = sourceImage.height
    //           canvas.requestPaint()
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
    function paintAfterGrabEffect() { timerPaintAfterEffectToImage.start() }
}
