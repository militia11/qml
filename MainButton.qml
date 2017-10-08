import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    anchors.horizontalCenter: parent.horizontalCenter
    width: 135; height: 135
    checkable: true
    style: ButtonStyle {
       background: Rectangle {
           id: recInButtonStyle
           color: control.hovered ? "#558C89" : "transparent"
           border.width: control.hovered ? 4 : 0
           border.color: control.hovered ?  Qt.lighter("#74AFAD", 1.13) : "#888"
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
