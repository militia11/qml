import QtQuick 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Slider {
    id: control
    enabled: true
    anchors.horizontalCenter: parent.horizontalCenter
    visible: parent.visible
    value: 0.5
    focus: true
    property string maineColor: "#74AFAD"

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 169
        implicitHeight: 5
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: Qt.lighter("#74AFAD", 1.13)

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: "#74AFAD"
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 13
        color: control.pressed ? "#ECECEA" : Qt.lighter(maineColor, 1.055)
        border.color: Qt.lighter("#74AFAD", 1.3)
    }
}
