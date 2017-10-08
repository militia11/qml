import QtQuick 2.3
import QtQuick.Window 2.2

// TODO ANIMACJE PARTICLE GDY START I/A TAKZE BUTTONS NA EFFECTS

//kolory
// Qt.lighter("#74AFAD", 1.3)
//Qt.lighter("#558C89", 1.2) D9853B
Window {
    id: root
    width: 1580
    height: 800
    property alias canvas: canvas
    property alias item1: item1
    visible: true
    minimumHeight: 800

    Background {
        id: bck
    }

    Image {
        id: sourceImage
        //fillMode: Image.PreserveAspectFit
        visible: false
        source: "qrc:///images/sourceImage.png"
    }

    Image {
        id: tImage
        visible: false
        source: "qrc:///images/sourceImage.png"
    }

    Row {
        id: main
        y: 0
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 10
        move: Transition {
                NumberAnimation { properties: "x,y"; duration: 900 }
        }
        spacing: 10

        FancyPathView {
            id: pathViewButtons

            anchors.verticalCenter: parent.verticalCenter
        }

        ListModel {
            id: effectsNames
            ListElement { name: "EFFECTS" }
            ListElement { name: "PAINT" }
            ListElement { name: "SHAPES" }
            ListElement { name: "TEXT" }
            ListElement { name: "COLORS" }
            ListElement { name: "EDGE" }
            ListElement { name: "BLUR" }
            ListElement { name: "RADIAL BLUR" }
            ListElement { name: "BRIGHTNESS" }
            ListElement { name: "SHARPEN" }
            ListElement { name: "LUMINANCE" }
            ListElement { name: "COLORIZE" }
            ListElement { name: "HSL" }
            ListElement { name: "WAVE" }
        }

        FancyPathDelegate {
            id: buttonsViewDelegate
        }

        Tools {
            id: tools
            width: 170
            height: 800
            antialiasing: false
            visible: false
        }

        Item {
            id: item1
            width: 1150
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            Rectangle {
                id: canvasBackground
                property color colour: "transparent"
                border.width: 10
                border.color: Qt.lighter("#74AFAD", 1.13)
                color: colour
                anchors.fill: parent
            }

            FancyCanvas {
                id: canvas
                width: parent.width - 20; height: parent.height- 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Loader {
                    id: loaderCamera
                    anchors.fill: parent
                }
            }

            Effects {
                id: effects
            }
        }

        MainButtons {
            id: mainButtons
            height: 800
        }
    }

    ImageDialog {
        id: imageDialog
    }

    Timers {id: timers}

    Component.onCompleted: {
       // canvas.loadImage = true
        effects.visibleEffect()
//        pathViewButtons.positionViewAtIndex(9, PathView.Center)
//        tools.switchActiveToolbars("SHARPEN")
//          pathViewButtons.positionViewAtIndex(2, PathView.Center)
//          tools.switchActiveToolbars("SHAPES")
//       tools.visible = true
//           var keys = Object.keys(root);
//           for(var i=0; i<keys.length; i++) {
//             var key = keys[i];
//             // prints all properties, signals, functions from object
//             console.log(key + ' : ' + root[key]);
//           }
    }
}
