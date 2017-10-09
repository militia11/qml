import QtQuick 2.0

Column {
    parent: tools
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    visible: false
    spacing: 10
    property bool autoSave: true
    onVisibleChanged: {
        if(!visible && autoSave) {
            autoSave = false
            effects.toImage()
        }
    }
}
