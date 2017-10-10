import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Component {
    Button {
       id: wrapper
       text: name
       width: 180; height: 115
       scale: PathView.itemScale
       z: PathView.itemZ
       property variant rotX: PathView.itemAngle
       transform: Rotation {
           axis { x: 1; y: 0; z: 0 }
           angle: wrapper.rotX;
           origin { x: 96; y: 56; }
       }
       style: ButtonStyle {
           background: Rectangle {
               id: recInButtonStyle
               border.width: wrapper.PathView.isCurrentItem || control.hovered ? 4 : 1
               border.color: wrapper.PathView.isCurrentItem || control.hovered ? "#558C89" : "#888"
               radius: 4
               gradient: Gradient {
                  GradientStop { position: 0 ; color: wrapper.PathView.isCurrentItem || control.hovered ? "#fc9941" : "#66aaa7" }
                  GradientStop { position: 1 ; color: wrapper.PathView.isCurrentItem || control.hovered ? "#D9853B" : "#558C89" }
               }
           }
        label: Text {
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Lucida Sans Unicode" //Helvetica
            font.pointSize: 18.5
            color: wrapper.PathView.isCurrentItem ? Qt.lighter("#74AFAD", 1.51) : Qt.lighter("#74AFAD", 1.28)//"#ECECEA"
            text: control.text
           }
        }
    }
}
