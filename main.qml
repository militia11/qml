import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Window {
    id: root
    visible: true
    minimumWidth: 800 ;minimumHeight: 810
    width: buttonsColumn.width + canvas.width + 30
    height: canvas.height + 30
    color: "#333333"
    property bool reqRepaintImage: false

    function switchActiveToolbars(row) {
        switch(row) {
            case paintTools:
                sheWave.visible = false
                paintTools.visible = true;
                sheRgbTool.visible = false
                canvas.paintMode = true;
                break;
            case sheRgbTool:
                paintTools.visible = false;
                sheRgbTool.visible = true
                canvas.paintMode = false
                sheRgb.red = 1.0
                sheRgb.green = 1.0
                sheRgb.blue = 1.0
                break;
            case waveTool:
                waveTool.visible = true;
                paintTools.visible = false;
                sheRgbTool.visible = false;
                break;
        }
    }

    Column {
        id: buttonsColumn
        spacing: 3
        x: parent.x + 10
        y: parent.y + 10
        ExclusiveGroup { id: excGroup}

        LeftMenuButton {
            id: buttonPaint
            checked: true
            width: buttonsColumn.width
            text: "PAINT"
            onClicked: {
                switchActiveToolbars(paintTools)
            }
        }

        LeftMenuButton {
            text: "LOAD IMAGE"
            onClicked: {
                loadedImage.source = "sourceImage.png"
                canvas.width = loadedImage.sourceSize.width
                canvas.height = loadedImage.sourceSize.height
                canvas.requestLoadImage = true
                canvas.requestPaint()
            }
        }

        LeftMenuButton {
            text: "COLOR CHANNELS"
            onClicked: {
                sheActivate(sheRgb)
                switchActiveToolbars(sheRgbTool)
            }
        }

        LeftMenuButton {
            id: lastButton
            text: "WAVE"
            onClicked: {
                sheActivate(sheWave)
                switchActiveToolbars(waveTool)
            }
        }

        Column {
            id: paintTools
            visible: false
            property color paintColor: "blue"
            clip: false
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20

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

            FancySlider {
                id: sliderCanvasBrush
                minimumValue: 0.5
                maximumValue: 30
                value: 2.5
                onValueChanged: {
                    canvas.lineWidth = sliderCanvasBrush.value
                }
            }
        }
    }

        Column {
            id: waveTool
            y: lastButton.y + lastButton.height + 20
            visible: false
            spacing: 5
            FancySlider {
                id: frequency
                minimumValue: 1
                maximumValue: 7.4
                value: 4.2
                onValueChanged: {
                    sheWave.frequency = frequency.value
                }
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

        Column {
            id: sheRgbTool
            y: lastButton.y + lastButton.height + 20
            visible: false
            spacing: 5
            property color paintColor: "red"
            onVisibleChanged: {
                sheApplyToCanvas(sheRgb)
                sheZaslonCanvas(sheRgb)
                root.reqRepaintImage = true;
            }

            Repeater {
                model:  ["red", "green", "blue"]

                RgbSlider {
                    id: slider
                    visible: parent.visible
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    style: SliderStyle {
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "lightblue" : modelData
                            border.color: Qt.lighter(modelData, 1.2)
                            border.width: 2
                            implicitWidth: 26
                            implicitHeight: 26
                            radius: 8
                        }
                    }
                    onVisibleChanged: {
                        if(visible) {
                        switch(modelData) {
                            case "red":
                                slider.value = 1.0
                                break;
                            case "green":
                                slider.value = 1.0
                                break;
                            case "blue":
                                slider.value = 1.0
                                break;
                        }
                        }
                    }

                    onValueChanged: {
                        switch(modelData) {
                            case "red":
                                sheRgb.red = slider.value
                                break;
                            case "green":
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

    function getCanvasDataToSourceImage() {
        var url = canvas.toDataURL('image/png')
        sourceImage.source = url
    }

    function sheZaslonCanvas(she) {
        she.anchors.fill = canvas
        she.visible = true
    }

    function sheActivate(she) {
        getCanvasDataToSourceImage()
        for (var i=0; i< 10000000;i++) {
        }
        sheZaslonCanvas(she)
    }

    function sheApplyToCanvas(she) {
        getCanvasDataToSourceImage()
        sheToTargetImage(she)
    }

    function sheToTargetImage(she) {
        if(she.grabToImage(function(result) {
            targetImage.source = result.url;
            },
            Qt.size(canvas.width, canvas.height))) {
        } else {
            console.log("grabDone: " + grabDone)
        }
    }

    Canvas {
        function loadImageInCanvas(context) {
            context.drawImage(loadedImage, 0, 0)
            context.save()
        }

        function repaintImageInCanvas(context) {
            context.drawImage(targetImage, 0, 0)
            context.save()
        }
        id: canvas
        property bool paintMode: true
        anchors {
            left: buttonsColumn.right
            top: parent.top
            topMargin: 10
            leftMargin: 10
        }
        property real lastX
        property real lastY
        property color color: paintTools.paintColor
        property bool requestLoadImage: false
        property bool requestRepaintImage: false
        property real lineWidth: 2.5

        onPaint: {
            var ctx = getContext('2d')
            if(canvas.requestLoadImage) {
                canvas.loadImageInCanvas(ctx)
                canvas.requestLoadImage = false
            } else if(canvas.requestRepaintImage) {
                canvas.repaintImageInCanvas(ctx)
                canvas.requestRepaintImage = false
            }
            if(paintMode) {
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
            anchors.rightMargin: -8
            anchors.bottomMargin: -8
            anchors.leftMargin: 8
            anchors.topMargin: 8
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
                    sheRgb.visible = false
                    canvas.requestPaint()
                }
            }
        }
    }

    Image {
        id: loadedImage
        visible: false
    }

    Image {
        id: sourceImage
        visible: false
    }

    Image {
        id: targetImage
        visible: false
    }

    ShaderEffect {
        id: sheRgb
        visible: true
        width: sourceImage.width; height: sourceImage.height
        property variant source: sourceImage
        property real red: 1.0
        property real green: 1.0
        property real blue: 1.0
        property string activeChannel: "red"
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
        switchActiveToolbars(paintTools)
//        var keys = Object.keys(root);
//           for(var i=0; i<keys.length; i++) {
//             var key = keys[i];
//             // prints all properties, signals, functions from object
//             console.log(key + ' : ' + root[key]);
//           }
    }
}

