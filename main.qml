import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2

Window {
    id: root
    visible: true
    minimumWidth: 950 ; minimumHeight: 700
    width: 200 + 180 + 1000 + 80

    Background {
        id: bck
        width: root.width
        height: root.height
    }

    Image {
        id: sourceImage
        visible: false
        source: "sourceImage.png"
    }

    Row {
        id: main
        anchors.left: parent.left
        anchors.leftMargin: 10
        move: Transition {
                NumberAnimation { properties: "x,y"; duration: 900 }
        }
        spacing: 10

        PathView {
            id: pathViewButtons
            width: 200; height: root.height
            delegate: buttonsViewDelegate
            model: effectsNames
            focus: true
            property bool firstStart: true
            property string keyButton: ""

            path: Path {
                startX: pathViewButtons.width/2
                startY: 0
                PathAttribute { name: "itemZ"; value: 0 }
                PathAttribute { name: "itemAngle"; value: -90.0; }
                PathAttribute { name: "itemScale"; value: 0.5; }
                PathLine { x: pathViewButtons.width/2; y: pathViewButtons.height*0.4; }
                PathPercent { value: 0.48; }
                PathLine { x: pathViewButtons.width/2; y: pathViewButtons.height*0.5; }
                PathAttribute { name: "itemAngle"; value: 0.0; }
                PathAttribute { name: "itemScale"; value: 1.0; }
                PathAttribute { name: "itemZ"; value: 100 }
                PathLine { x: pathViewButtons.width/2; y: pathViewButtons.height*0.6; }
                PathPercent { value: 0.52; }
                PathLine { x: pathViewButtons.width/2; y: pathViewButtons.height; }
                PathAttribute { name: "itemAngle"; value: 90.0; }
                PathAttribute { name: "itemScale"; value: 0.5; }
                PathAttribute { name: "itemZ"; value: 0 }
            }
            pathItemCount: 16
            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5

            onMovementStarted: {
                pathViewButtons.deactivateEffectsButton()
                tools.activateTipTool()
                timerScrollPathView.start()
                tools.visible = true
                if (mainButtons.state == "expanded") {
                   mainButtons.state = "slim"
                }
            }

            onMovementEnded: {
                timerScrollPathView.running = false
                tools.switchActiveToolbars(pathViewButtons.currentItem.text)
                effects.switchActiveEffect(pathViewButtons.currentItem.text)
            }

            Keys.onUpPressed: {
                incrementCurrentIndex()
                pathViewButtons.deactivateEffectsButton()
                tools.visible = true
                var i = pathViewButtons.currentIndex
                keyButton = effectsNames.get(++i).name
                tools.switchActiveToolbars(keyButton)
            }

            Keys.onDownPressed: {
                decrementCurrentIndex()
                pathViewButtons.deactivateEffectsButton()
                tools.visible = true
                var i = pathViewButtons.currentIndex
                keyButton = effectsNames.get(--i).name
                tools.switchActiveToolbars(keyButton)
            }

            Keys.onReleased: {
                effects.switchActiveEffect(keyButton)
            }

            function deactivateEffectsButton() {
                if(firstStart) {
                    effectsNames.remove(0)
                    firstStart = false
                }
            }

            function activateEffectsButton() {
                if(pathViewButtons.currentIndex!=0) {
                    effectsNames.insert(0, { name: "EFFECTS"} )
                    pathViewButtons.positionViewAtIndex(0, PathView.Center)
                    effects.switchActiveEffect("EFFECTS")
                    firstStart = true
                }
            }

            function activateScroll() {
                tools.printToolTip(pathViewButtons.currentItem.text)
            }
        }

        ListModel {
            id: effectsNames
            ListElement { name: "EFFECTS" }
            ListElement { name: "PAINT" }
            ListElement { name: "SHAPES" }
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

        Component {
           id: buttonsViewDelegate

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
                       border.width:wrapper.PathView.isCurrentItem || control.hovered ? 4 : 1
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
                    font.family: "Helvetica"
                    font.pointSize: 18.5
                    color: "#ECECEA"
                    text: control.text
                   }
                }
           }
        }

        Tools {
            id: tools
            width: 170; height: 280
            visible: false
        }


        FancyCanvas {
            id: canvas
        }

        Effects {
            id: effects
            parent: canvas
        }

        MainButtons {
            id: mainButtons
            height: canvas.height + 40
        }
    }

    ImageDialog {
        id: imageDialog
    }

    Timer {
        id: timer
        interval: 40
        repeat: false
        running: false
        onTriggered: {
           canvas.requestPaint()
        }
    }

//    Timer {
//        id: delayTimer
//        interval: 100
//        repeat: false
//        running: false
//        onTriggered: {
//           // do nothing
//        }
//    }

    Timer {
        id: timerScrollPathView
        interval: 40
        repeat: true
        running: false
        onTriggered: {
           pathViewButtons.activateScroll()
        }
    }

    Component.onCompleted: {
        canvas.loadImage = true
        //canvas.requestPaint()
        effects.visibleEffect()
//         pathViewButtons.positionViewAtIndex(2, PathView.Center)
//        tools.switchActiveToolbars("SHAPES")
//       tools.visible = true
//           var keys = Object.keys(root);
//           for(var i=0; i<keys.length; i++) {
//             var key = keys[i];
//             // prints all properties, signals, functions from object
//             console.log(key + ' : ' + root[key]);
//           }
    }
}

