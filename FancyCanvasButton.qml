import QtQuick 2.3
import QtQuick.Controls 2.2

Button {
    id: control
    width: 93; height: 93
    property string sourceImage
    opacity: 0
    signal activate
    background:
        Rectangle {
         id: recInButtonStyle
            color: control.hovered ? Qt.lighter("#558C89", 1.2) : "transparent"
            border.width: control.hovered ? 4 : 0
            border.color: Qt.lighter("#74AFAD", 1.3)
            radius: 5
        }

        Image {
           width: 93; height: 93
           anchors.fill: recInButtonStyle
           source: control.sourceImage
       }

    onClicked: {
        activate()
    }

    Behavior on x {
        PropertyAnimation {
            duration: 1550
            easing.type: Easing.OutExpo
            //easing.type: Easing.InOutElastic
            //easing.type: Easing.InExpo
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 1360
        }
    }
}
