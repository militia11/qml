import QtQuick 2.0

Rectangle {
    width: 50; height: 50
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 8
    signal clicked
    border.width: 1.2
    border.color: Qt.lighter("#74AFAD", 1.3)

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
