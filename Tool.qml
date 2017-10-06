import QtQuick 2.0

Column {
    parent: tools
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    visible: false
    spacing: 6
    onVisibleChanged: {
        if(!visible) {
            effects.toImage()
            canvas.repaintImage = true;
            timerPaintAfterEffectToImage.start()
        }
    }
}
