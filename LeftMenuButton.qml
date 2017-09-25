import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    id: root
    width: 180
    checkable: true
    exclusiveGroup: excGroup
    anchors.horizontalCenter: parent.horizontalCenter
    style: ButtonStyle {
            id: x
            background: Rectangle {
                id: recInButtonStyle
                implicitWidth: 100
                implicitHeight: 25
                border.width: control.checked ? 3 : 1
                border.color: control.checked ? "#04e824" : "#888"
                radius: 4
                gradient: Gradient {
                   GradientStop { position: 0 ; color: control.pressed ? "#04e824" : "#04e824" }
                   GradientStop { position: 1 ; color: control.pressed ? "#18ff6d" : "#285238" }
                }
            }
        }
}//flat highlited
