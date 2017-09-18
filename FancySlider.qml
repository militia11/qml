import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {
    enabled: true
    width: 155;
    style: SliderStyle {
        groove: Rectangle {
            implicitWidth: 155
            implicitHeight: 8
            color: "grey"
            radius: 8
        }
        handle: Rectangle {
            anchors.centerIn: parent
            color: control.pressed ? "lightblue" : "blue"
            border.color: "yellow"
            border.width: 2
            implicitWidth: 34
            implicitHeight: 34
            radius: 14
        }
    }
}
