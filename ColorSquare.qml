import QtQuick 2.0

Rectangle {
    id: root
    width: 43; height: 43
    anchors.horizontalCenter: parent.horizontalCenter
    signal clicked
    property bool active: false
    border.color: active? "white" : Qt.lighter("#74AFAD", 1.13)
    border.width: active? 4 : 3

    MouseArea {
        id: area
        anchors.fill :parent
        onClicked: {
            root.clicked()
        }
    }
}
