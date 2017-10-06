import QtQuick 2.2
import QtQuick.Dialogs 1.0

FileDialog {
    title: "Please choose a image file"
    folder: shortcuts.pictures
    //nameFilters: [ "Image files (*.jpg)", "All files (*)" ]
    nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
    visible: false

    onAccepted: {
        sourceImage.source = imageDialog.fileUrl
        sourceImage.update()
        canvas.loadImage = true
        canvas.requestPaint()
        pathViewButtons.activateEffectsButton()
        close()
    }

    onRejected: {
        close()
    }
    // TODO: dynamically
    //Component.onCompleted: visible = true
}
