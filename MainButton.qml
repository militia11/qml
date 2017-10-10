import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    id: control
    width: 138; height: 138
    property string sourceImage
    opacity: 1
    anchors.horizontalCenter: parent.horizontalCenter
    signal activate
    background:
        Rectangle {
         id: recInButtonStyle
            color: control.hovered || control.checked ? "#558C89" : "transparent"
            border.width: control.hovered || control.checked? 4 : 0
            border.color: control.hovered || control.checked? Qt.lighter("#74AFAD", 1.3) : "#888"
            radius: 16
        }

        Image {
           width: 109;height: 109
           anchors.fill: recInButtonStyle
           source: control.sourceImage
       }

    onClicked: {
        activate()
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 900
        }
    }
}
