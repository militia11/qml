import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import "logic.js" as Logic

Window {
    id: root
    visible: true
    minimumWidth: 700 ;minimumHeight: 710
    width: buttonsColumn.width + canvas.width + 30
    height: canvas.height + 20
    property bool reqRepaintImage: false

    Image {
        id: bck
        width: root.width
        height: root.height
        source: "bck.jpg"
    }

    Column {
        id: buttonsColumn
        spacing: 6
        x: parent.x + 10
        y: parent.y + 10
        ExclusiveGroup { id: excGroup}

        LeftMenuButton {
            id: buttonPaint
            checked: true
            width: buttonsColumn.width
            text: "PAINT"
            onClicked: {
                Logic.switchActiveToolbars(paintTools)
            }
        }

        LeftMenuButton {
            text: "COLOR CHANNELS"
            onClicked: {
                sheBlur.visible = false
                Logic.sheActivate(sheRgb)
                Logic.switchActiveToolbars(rgbTool)
            }
        }

        LeftMenuButton {
            text: "WAVE"
            onClicked: {
                sheBlur.visible = false
                Logic.sheActivate(sheWave)
                Logic.switchActiveToolbars(waveTool)
            }
        }

        LeftMenuButton {
            id: lastButton
            text: "BLUR"
            onClicked: {
                sheBlur.visible = true
                sheRgb.visible = false
                Logic.sheActivate(sheBlur)
                Logic.switchActiveToolbars(blurTool)
            }
        }
        Tool {
            id: blurTool

            onVisibleChanged: {
                if(!visible) {
                    console.log("not visible")
                    Logic.sheApplyToCanvas(sheBlur)
                    Logic.sheZaslonCanvas(sheBlur)
                    root.reqRepaintImage = true;
                    canvas.requestPaint()
                }
            }
            FancySlider {
                id: blurSlider
                width: 155;
                visible: parent.visible
                anchors.horizontalCenter: parent.horizontalCenter
                minimumValue: 0
                maximumValue: 35
                value: 0
                enabled: true
                onValueChanged: {
                    sheBlur.radius = blurSlider.value
                }
            }
        }

        Tool  {
            id: none
        }

        Tool {
            id: paintTools
            spacing: 3
            property color paintColor: "blue"

            TextTool {
                text: "pen size"
            }

            FancySlider {
                id: sliderCanvasBrush
                minimumValue: 0.5
                maximumValue: 30
                value: 2.5
                onValueChanged: {
                    canvas.lineWidth = sliderCanvasBrush.value
                }
            }

            Repeater {
                model: ["lightblue", "#33B5E5", "blue",
                    "lightgreen", "#99CC00", "green","yellow",
                    "gold", "#FFBB33","#FF4444" , "red", "black"]
                ColorSquare {
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: modelData
                    active: parent.paintColor === color
                    onClicked: {
                        parent.paintColor = color
                    }
                }
            }

        }
    }

        Tool {
            id: waveTool
            TextTool {
                text: "frequency"
            }
            FancySlider {
                id: frequency
                minimumValue: 1
                maximumValue: 7.4
                value: 4.2
                onValueChanged: {
                    sheWave.frequency = frequency.value
                }
            }
            TextTool {
                text: "amplitude"
            }
            FancySlider {
                id: amplitude
                minimumValue: 0.01
                maximumValue: 0.19
                value: 0.1
                onValueChanged: {
                    sheWave.amplitude = amplitude.value
                }
            }
        }

        Tool {
            id: rgbTool
            property color paintColor: "red"
            onVisibleChanged: {
                if(!visible) {
                Logic.sheApplyToCanvas(sheRgb)
                Logic.sheZaslonCanvas(sheRgb)
                root.reqRepaintImage = true;
                canvas.requestPaint()
                }
            }

            Repeater {
                model: ["red", "#04e824", "blue"]

                FancySlider {
                    id: slider
                    width: 155;
                    visible: parent.visible
                    anchors.horizontalCenter: parent.horizontalCenter
                    maineColor: modelData
                    minimumValue: 0.0
                    maximumValue: 2.0
                    value: 1.0
                    enabled: true
                    onVisibleChanged: {
                        if(visible) {
                            slider.value = 1.0
                        }
                    }

                    onValueChanged: {
                        switch(modelData) {
                            case "red":
                                sheRgb.red = slider.value
                                break;
                            case "#04e824":
                                sheRgb.green = slider.value
                                break;
                            case "blue":
                                sheRgb.blue = slider.value
                                break;
                        }
                    }
                }
            }
        }

    Image {
        id: sourceImage
        visible: false
        source: "sourceImage.png"
    }

    Image {
        id: targetImage
        visible: false
    }


    Canvas {
        id: canvas
        property bool paintMode: true
        anchors {
            left: buttonsColumn.right
            top: parent.top
            topMargin: 10
            leftMargin: 10
        }
        width: sourceImage.sourceSize.width
        height: sourceImage.sourceSize.height
        property real lastX
        property real lastY
        property color color: paintTools.paintColor
        property bool requestRepaintImage: false
        property real lineWidth: 2.5
        property bool firstPaint: true
        onPaint: {
            var ctx = getContext('2d')
            if (firstPaint) {
                Logic.loadImageInCanvas(ctx)
                firstPaint = false
            }

            if (canvas.requestRepaintImage) {
                Logic.repaintImageInCanvas(ctx)
                canvas.requestRepaintImage = false
            }
            if (paintMode) {
                ctx.lineWidth = canvas.lineWidth
                ctx.strokeStyle = canvas.color
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area.mouseX
                lastY = area.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                if(canvas.paintMode) {
                    canvas.lastX = mouseX
                    canvas.lastY = mouseY
                }
            }
            onPositionChanged: {

                if(root.reqRepaintImage) {
                    root.reqRepaintImage = false
                    canvas.requestRepaintImage = true
                    canvas.requestPaint()
                }
                if(canvas.paintMode) {
                    blurSlider.value = 0
                    sheRgb.visible = false
                    sheBlur.visible = false
                    canvas.requestPaint()
                }
            }
        }
    }

    FastBlur {
        id: sheBlur
        visible: false
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        radius: 0
    }

    ShaderEffect {
        id: sheRgb
        visible: true
        width: sourceImage.width; height: sourceImage.height
        property variant source: sourceImage
        property real red: 1.0
        property real green: 1.0
        property real blue: 1.0
        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform lowp float red;
            uniform lowp float green;
            uniform lowp float blue;
            void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(red, green, blue, 1.0) * qt_Opacity;
            }"
    }

    ShaderEffect {
        id: sheWave
        property variant source: sourceImage
        property real frequency: 4.2
        property real amplitude: 0.1
        property real time: 0.0
        NumberAnimation on time {
            from: 0; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
        }

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform highp float frequency;
            uniform highp float amplitude;
            uniform highp float time;
            void main() {
                highp vec2 pulse = sin(time - frequency * qt_TexCoord0);
                highp vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.x, -pulse.x);
                gl_FragColor = texture2D(source, coord) * qt_Opacity;
            }"
    }

    Component.onCompleted: {
        Logic.switchActiveToolbars(paintTools)
        sheRgb.visible = false
        sheBlur.visible = false
//        var keys = Object.keys(root);
//           for(var i=0; i<keys.length; i++) {
//             var key = keys[i];
//             // prints all properties, signals, functions from object
//             console.log(key + ' : ' + root[key]);
//           }
    }
}

