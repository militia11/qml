import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2

AnimatedButton {
    id: control
    onClicked: {
        messageDialog.open()
    }
    sourceImage: "qrc:///images/apply.png"
    MessageDialog {
         id: messageDialog
         title: "Please confirm"
         icon: StandardIcon.Question
         standardButtons: StandardButton.Yes | StandardButton.No
         text: "Do you want accept effect?"
         onYes: {
             control.click()
             opacityAnimation.running = true
             close()
         }
         onNo: close()
     }
}
