import QtQuick 2.0

Rectangle {
    id: root
    width: 43; height: 43
    signal clicked
    property bool active: false
    border.color: active? "#18ff6d" : "#f0f0f0"
    border.width: 2

    MouseArea {
        id: area
        anchors.fill :parent
        onClicked: {
            root.clicked()
        }
    }
}
