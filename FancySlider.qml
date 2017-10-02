import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {
    enabled: true
    anchors.horizontalCenter: parent.horizontalCenter
    width: 155;
    visible: parent.visible
    property string maineColor: "#74AFAD"
    focus: true

    style: SliderStyle {
        groove: Rectangle {
            implicitWidth: 155
            implicitHeight: 8
            color: maineColor
            radius: 8
        }
        handle: Rectangle {
            anchors.centerIn: parent
            color: control.pressed ? "#ECECEA" : Qt.lighter(maineColor, 1.07)
            border.color: Qt.lighter(maineColor, 1.13)
            border.width: 2
            implicitWidth: 34
            implicitHeight: 34
            radius: 14
        }
    }
}

//import QtQuick 2.6
//import QtQuick.Controls 2.1

//Slider {
//    id: control
//    value: 0.5

//    background: Rectangle {
//        x: control.leftPadding
//        y: control.topPadding + control.availableHeight / 2 - height / 2
//        implicitWidth: 200
//        implicitHeight: 4
//        width: control.availableWidth
//        height: implicitHeight
//        radius: 2
//        color: "#bdbebf"

//        Rectangle {
//            width: control.visualPosition * parent.width
//            height: parent.height
//            color: "#21be2b"
//            radius: 2
//        }
//    }

//    handle: Rectangle {
//        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
//        y: control.topPadding + control.availableHeight / 2 - height / 2
//        implicitWidth: 26
//        implicitHeight: 26
//        radius: 13
//        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
//        border.color: "#bdbebf"
//    }
//}
