import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    width: 120; height: 100
    anchors.horizontalCenter: parent.horizontalCenter

    style: ButtonStyle {
         background:
             Rectangle {
             border.width: control.activeFocus ? 3 : 1
             border.color: "#888"
             radius: 4
             gradient: Gradient {
                 GradientStop { position: 0 ; color: control.pressed ? "red" : "#eee" }
                 GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
             }
         }
    }
}

