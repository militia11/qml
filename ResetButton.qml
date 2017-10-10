import QtQuick 2.9
import QtQuick.Controls 2.1

AnimatedButton {
    id: control
    sourceImage: "qrc:///images/reset.png"

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
