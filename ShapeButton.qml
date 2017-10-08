import QtQuick 2.3
import QtQuick.Controls 2.1

Button {
    id: control
    anchors.horizontalCenter: parent.horizontalCenter
    property real subRecRadius: 0
    width: 50; height: 50
    checkable: true
    background:
        Rectangle {
             id: arecInButtonStyle
             color: {
                 if(control.hovered)
                     return Qt.lighter("#D9853B", 1.18)
                 else if(control.checked)
                     return Qt.lighter("#D9853B", 1.09)
                 else
                     return Qt.lighter("#558C89", 1.2)
             }
             border.width: control.hovered ? 3.1 : 1.2
             border.color: control.hovered ?  Qt.lighter("#74AFAD", 1.3) : Qt.lighter("#74AFAD", 1.3)
             radius: 8
             Rectangle {
                 width: 32; height: 32
                 anchors.centerIn: parent
                 color: "transparent"
                 border.width: control.hovered ? 3 : 2
                 border.color: control.hovered ?  Qt.lighter("#74AFAD", 1.3) : Qt.lighter("#74AFAD", 1.3)
                 radius: subRecRadius
             }
        }
}
