import QtQuick 2.9
import QtQuick.Controls 2.1

AnimatedButton {
    id: control
    sourceImage: "qrc:///images/smallVideo.png"
    onClicked: {
        messageDialog.open()
    }
    Dialog {
        id: messageDialog
        parent: ApplicationWindow.overlay
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        title: "Please confirm"
        standardButtons: Dialog.Yes | Dialog.No

        Column {
             spacing: 20
             anchors.fill: parent
             Label {
                 text: "Do you want accept effect?"
             }
        }

        onAccepted: {
            control.click()
            opacityAnimation.running = true
            close()
        }

        onRejected: {
            close()
        }

        PropertyAnimation {
            id: opacityAnimation
            target: control
            property: "opacity"
            from: 1
            to: 0
            duration: 900
        }
    }
}


