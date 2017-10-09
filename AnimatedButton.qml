import QtQuick 2.9
import QtQuick.Controls 2.1

Button {
    id: control
    signal click
    anchors.horizontalCenter: parent.horizontalCenter
    width: 50; height: 50
    enabled: control.opacity
    property string sourceImage
    background:
        Rectangle {
         id: recInButtonStyle
         color: control.hovered ? "#D9853B" : "transparent"
         border.width: control.hovered ? 4 : 0
         border.color: control.hovered ?  Qt.lighter("#74AFAD", 1.13) : "#888"
            radius: 4
        }
        Image {
            anchors.fill: recInButtonStyle
            source: sourceImage
        }

    onClicked: {
        opacityAnimation.running = true
        control.click()
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
