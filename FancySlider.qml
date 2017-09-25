import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {
    enabled: true
    width: 155;
    property string maineColor: "#04e824"
    style: SliderStyle {
        groove: Rectangle {
            implicitWidth: 155
            implicitHeight: 8
            color:  Qt.darker(maineColor, 1.3)
            radius: 8
        }
        handle: Rectangle {
            anchors.centerIn: parent
            color: control.pressed ? Qt.lighter(maineColor, 1.16) : Qt.darker(maineColor, 1.13)
            border.color: Qt.darker(maineColor, 1.29)
            border.width: 2
            implicitWidth: 34
            implicitHeight: 34
            radius: 14
        }
    }
}
