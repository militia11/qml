import QtQuick 2.2
import QtQuick.Dialogs 1.0

ColorDialog {
     visible: false
     title: "Please choose a color"
     showAlphaChannel: true
     onRejected: {
         close()
     }
     // maybe TODO dynamically
     //Component.onCompleted: visible = true
}
