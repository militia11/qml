import QtQuick 2.7
import QtQuick.Dialogs 1.0

FileDialog {
    title: "Please choose a image file"
    folder: shortcuts.pictures
    nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
    visible: false

    onAccepted: {
        sourceImage.source = imageDialog.fileUrl
        sourceImage.update()
        canvas.loadImage = true
        canvas.requestPaint()
     //   effects.switchActiveEffect("CURTAIN")
        pathViewButtons.activateEffectsButton()
        close()
    }

    onRejected: {
        close()
    }
}
