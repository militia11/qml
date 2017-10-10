import QtQuick 2.5
import QtMultimedia 5.6

Item {
    parent: item1
    width: 800; height: 450

    anchors.top: parent.top
    anchors.topMargin: 10
    anchors.left: parent.left
    anchors.leftMargin: 10

    VideoOutput {
        id: videoStream
        anchors.fill: parent
        source: camera
    }

    FancyCanvasButton {
        id: fancyCanvasButton
        x: 1150
        y: 585
        sourceImage: "qrc:/images/camera.png"

        onActivate: {
            camera.imageCapture.capture();
        }
    }

    Connections {
        target: camera.imageCapture

        onImageCaptured: {
            tImage.source = preview;
            canvas.fillWhite = true
            //canvas.requestPaint()
            canvas.repaintImage = true;
            exit()
            timers.requestPaintAfterDelay()
        }
    }

    function exit() {
        fancyCanvasButton.x += 160
        fancyCanvasButton1.x += 240
        fancyCanvasButton.opacity = 0
        fancyCanvasButton1.opacity = 0
        timerDelayReturnedIcon.running = true
    }

     Timer {
         id: timerDelayReturnedIcon
         interval: 1000
         repeat: false
         running: false
         onTriggered: {
             pathViewButtons.interactive = true
             loaderOnCanvas.deactivateLoader();
             mainButtons.activeButtons()
             mainButtons.disableChecked()
         }
     }

     FancyCanvasButton {
         id: fancyCanvasButton1
         x: 1140
         y: 585
         sourceImage: "qrc:/images/stop.png"

         onActivate: {
             exit()
         }
     }

    Camera {
        id: camera
    }

    Component.onCompleted: {
         canvas.visible = false
         fancyCanvasButton.x -= 130
         fancyCanvasButton1.x -= 210
         fancyCanvasButton.opacity = 1
         fancyCanvasButton1.opacity = 1
   }
}
