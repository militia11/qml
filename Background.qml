import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    width: parent.width; height: parent.height

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(parent.width, parent.height)
        gradient: Gradient {
          GradientStop { position: 0.0; color: "#a1e2e0" }//81c4c2 //8acecc
          GradientStop { position: 0.5; color: "#6fa5a3" }
          GradientStop { position: 1.0; color: "#a1e2e0" }
        }
    }
}
