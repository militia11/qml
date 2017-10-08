import QtQuick 2.5
import QtMultimedia 5.6

Item {
    width: 1130
    height: 760

    VideoOutput {
        anchors.fill: parent
        source: camera
    }

    Camera {
        id: camera
    }
}
