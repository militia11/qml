import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

Button {
    id: control
    signal accept
    anchors.horizontalCenter: parent.horizontalCenter
    width: 50; height: 50
    enabled: control.opacity
    background:
        Rectangle {
         id: arecInButtonStyle
         color: control.hovered ? "#D9853B" : "transparent"
         border.width: control.hovered ? 4 : 0
         border.color: Qt.lighter("#74AFAD", 1.13)
            radius: 4
        }
        Image {
            anchors.fill: arecInButtonStyle
            source: "qrc:///images/apply.png"
       }

    onClicked: {
        messageDialog.open()
    }

    MessageDialog {
         id: messageDialog
         title: "Please confirm"
         icon: StandardIcon.Question
         standardButtons: StandardButton.Yes | StandardButton.No
         text: "Do you want accept effect?"
         onYes: {
             control.accept()
             opacityAnimation.running = true
             close()
         }
         onNo: close()
     }

    PropertyAnimation {
        id: opacityAnimation
        target: control
        property: "opacity"
        from: 1
        to: 0
        duration: 1050
    }
}
