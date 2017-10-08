import QtQuick 2.0

Column {
    parent: tools
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    visible: false
    spacing: 10
    onVisibleChanged: {
        if(!visible) {
            effects.toImage()
        }
    }
}
