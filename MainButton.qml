import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    anchors.horizontalCenter: parent.horizontalCenter
    width: 145; height: 145
    style: ButtonStyle {
       background: Rectangle {
           id: recInButtonStyle
           color: control.hovered || control.checked ? "#558C89" : "transparent"
           border.width: control.hovered || control.checked? 5 : 0
           border.color: control.hovered || control.checked? Qt.lighter("#74AFAD", 1.3) : "#888"
           radius: 16
       }
    }
    opacity: 0
    Behavior on opacity {
        NumberAnimation {
            duration: 1000
        }
    }
}
