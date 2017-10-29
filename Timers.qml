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

    Timer {
        id: timerDelayAfterCapture
        interval: 100
        repeat: false
        running: false
        onTriggered: {
           effects.activate()
           tools.resetVideo()
        }
    }

    Timer {
        id: timerRequestSave
        interval: 400
        repeat: false
        running: false
        onTriggered: {
//            effects.currentEffect.grabToImage(function(result) {
//                result.saveToFile("aaaaaaaa.png");
//            });
        }
    }

    function requestSave() { timerRequestSave.start() }
    function delayAfterCapture() { timerDelayAfterCapture.start() }
    function disabledScrollPathView() { timerScrollPathView.start() }
    function startScroll(){ timerScrollPathView.start()}
    function requestPaintAfterDelay() { timerRequestPaintAfterDelay.start() }

}
