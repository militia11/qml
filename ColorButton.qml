import QtQuick 2.0

Rectangle {
    width: 50; height: 50
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 8
    signal clicked

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
