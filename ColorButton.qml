import QtQuick 2.0

Rectangle {
    width: 120; height: 120
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 8
    signal clicked

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
