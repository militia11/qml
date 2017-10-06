import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import ShapesTypes 1.0
import CanvasModes 1.0

Item {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    property color colorStroke: "blue"
    property color colorFill: "lightgreen"
    property int strokeSize: frameSlider.value
    property Item currentTool: paintTool
    property int currentShape: Shapes.RECTANGLE
    property string currentComposite: "destination-over"

    TextArea {
        id: textTip
        anchors.horizontalCenter: parent.horizontalCenter
        focus: false
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        backgroundVisible: false
        font.bold : true
        font.family: "Helvetica"
        font.pointSize: 12.5
        style: TextAreaStyle {
                  textColor: "#558C89"
                  renderType: Text.NativeRendering
            }
    }

    Tool {
        id: paintTool
        spacing: 5
        onVisibleChanged: {}

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
                "lightgreen", "#99CC00", "green", "gold",
                "#FFBB33","#FF4444" , "red", "black"]
            ColorSquare {
                color: modelData
                active: root.colorStroke === color
                onClicked: {
                    root.colorStroke = color
                    eraserButton.checked = false
                }
            }
        }

        Button {
            id: eraserButton
            iconSource: "qrc:///images/eraser.png"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 75; height: 55
            checkable: true
            style: ButtonStyle {
               background: Rectangle {
                   id: recInButtonStyle
                   color: control.checked ? "white" : "transparent"
                   border.width: control.hovered || control.checked ? 3 : 0
                   border.color: control.hovered || control.checked ?  Qt.lighter("#74AFAD", 1.13) : "#888"
                   radius: 5
               }
            }
            onClicked: {
                if (eraserButton.checked) {
                    root.colorStroke = "transparent"
                }
            }
        }
    }
    // TEXT TOOL onVisibleChanged: {}
    Tool {
        id: shapesTool

        spacing: 5
        onVisibleChanged: {}

        ToolButton {
            text: "elipse"
            onClicked: {
                currentShape = Shapes.ELISPE
            }
        }

        TextTool {
            text: "fill"
        }
        ColorButton {
            color: colorFill
            onClicked: {colorDialogFill.open()}
        }

        TextTool {
            text: "frame"
        }
        ColorButton {
            color: colorStroke
            onClicked: colorDialogFrame.open()
        }
        FancySlider {
            id: frameSlider
            minimumValue: 1
            maximumValue: 45
            value: 1
            enabled: true
            onValueChanged: {
                root.strokeSize = frameSlider.value
            }
        }

        ColorSelectDialog {
            id: colorDialogFill
            onAccepted: {
                root.colorFill = colorDialogFill.color
                close()
            }
        }

        ColorSelectDialog {
            id: colorDialogFrame
            onAccepted: {
                root.colorStroke = colorDialogFill.color
                close()
            }
        }

        TextTool {
            text: "composition"
        }
        ComboBox {
            id: comboComposite
            width: 200
            model: [ 'destination-over', 'lighter',
                'qt-multiply', 'qt-screen', 'qt-overlay', 'qt-darken',
                'qt-lighten', 'qt-color-dodge', 'qt-color-burn',
                'qt-hard-light', 'qt-soft-light', 'qt-difference',
                'qt-exclusion' ]
            onCurrentTextChanged: currentComposite = comboComposite.currentText
        }
    }

    Tool {
        id: rgbTool
        property color paintColor: "red"

        Repeater {
            model: ["red", "#04e824", "blue"]

            FancySlider {
                id: slider
                maineColor: modelData
                minimumValue: 0.0
                maximumValue: 2.0
                value: 1.0
                enabled: true

                onVisibleChanged: {
                    if (visible) {
                        slider.value = 1.0
                    }
                }

                onValueChanged: {
                    switch(modelData) {
                        case "red":
                            effects.currentEffect.red = slider.value
                            break;
                        case "#04e824":
                            effects.currentEffect.green = slider.value
                            break;
                        case "blue":
                            effects.currentEffect.blue = slider.value
                            break;
                    }
                }
            }
        }
    }

    Tool {
        id: blurTool

        TextTool {
            text: "radius"
        }
        FancySlider {
            id: blurSlider
            minimumValue: 0
            maximumValue: 35
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.radius = blurSlider.value
            }
        }
    }

    Tool {
        id: brightnessContrastTool

        TextTool {
            text: "brightness"
        }
        FancySlider {
            id: brightnessSlider
            minimumValue: -1
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.brightness = brightnessSlider.value
            }
        }

        TextTool {
            text: "contrast"
        }
        FancySlider {
            id: contrastSlider
            minimumValue: -1
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.contrast = contrastSlider.value
            }
        }
    }

    Tool {
        id: luminanceTool

        TextTool {
            text: "gamma"
        }
        FancySlider {
            id: luminanceSlider
            width: 155;
            minimumValue: 0
            maximumValue: 2
            value: 1
            enabled: true
            onValueChanged: {
                effects.currentEffect.gamma = luminanceSlider.value
            }
        }
    }

    Tool {
        id: hslTool

        TextTool {
            text: "hue"
        }
        FancySlider {
            id: hSlider
            minimumValue: -1
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.hue = hSlider.value
            }
        }

        TextTool {
            text: "saturation"
        }
        FancySlider {
            id: sSlider
            minimumValue: -1
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.saturation = sSlider.value
            }
        }

        TextTool {
            text: "lightness"
        }
        FancySlider {
            id: lSlider
            minimumValue: -1
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.lightness = lSlider.value
            }
        }
    }

    Tool {
        id: colorizeTool

        TextTool {
            text: "hue"
        }
        FancySlider {
            id: chSlider
            minimumValue: 0
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.hue = chSlider.value
            }
        }

        TextTool {
            text: "saturation"
        }
        FancySlider {
            id: csSlider
            minimumValue: 0
            maximumValue: 1
            value: 1
            enabled: true
            onValueChanged: {
                effects.currentEffect.saturation = csSlider.value
            }
        }

        TextTool {
            text: "lightness"
        }
        FancySlider {
            id: clSlider
            minimumValue: -1
            maximumValue: 1
            value: 0
            enabled: true
            onValueChanged: {
                effects.currentEffect.lightness = clSlider.value
            }
        }
    }

    Tool {
        id: sharpenTool

        TextTool {
            text: "sharpness"
        }
        FancySlider {
            id: sharpSlider
            minimumValue: 0
            maximumValue: 18
            value: 9
            onValueChanged: {
                effects.currentEffect.amount = sharpSlider.value
            }
        }
    }

    Tool {
        id: edgeTool

        TextTool {
            text: "threshold"
        }
        FancySlider {
            id: edgeSlider
            minimumValue: 0
            maximumValue: 1
            value: 0.5
            onValueChanged: {
                effects.currentEffect.mixLevel = edgeSlider.value
            }
        }
    }

    Tool {
        id: radialBlurTool

        TextTool {
            text: "angle"
        }
        FancySlider {
            id: angleBlurSlider
            minimumValue: 0
            maximumValue: 30
            value: 0
            onValueChanged: {
                effects.currentEffect.angle = angleBlurSlider.value
            }
        }

        TextTool {
            text: "horizontal offset"
        }
        FancySlider {
            id: hOffsetSlider
            minimumValue: -100
            maximumValue: 100
            value: 0
            onValueChanged: {
                effects.currentEffect.verticalOffset = hOffsetSlider.value
            }
        }

        TextTool {
            text: "vertical offset"
        }
        FancySlider {
            id: vOffsetSlider
            minimumValue: -100
            maximumValue: 100
            value: 0
            onValueChanged: {
                effects.currentEffect.verticalOffset = vOffsetSlider.value
            }
        }
    }

    Tool {
        id: waveTool
        onVisibleChanged: {}

        TextTool {
            text: "frequency"
        }
        FancySlider {
            id: frequency
            minimumValue: 1
            maximumValue: 7.4
            value: 4.2
            onValueChanged: {
                effects.currentEffect.frequency = frequency.value
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
                effects.currentEffect.amplitude = amplitude.value
            }
        }
    }

    function switchActiveToolbars(action) {
        canvas.mode = CanvasModes.NONE
        switch(action) {
            case "PAINT":
                currentTool = paintTool
                canvas.mode = CanvasModes.DRAWING
                break;
            case "SHAPES":
                currentTool = shapesTool
                canvas.mode = CanvasModes.ADDSHAPES
                break;
            case "COLORS":
                currentTool = rgbTool
                break;
            case "TEXT":
                //  currentTool = toolText
                break;
            case "BLUR":
                currentTool = blurTool
                blurSlider.value = 0
                break
            case "BRIGHTNESS":
                currentTool = brightnessContrastTool
                brightnessSlider.value = 0
                contrastSlider.value = 0
                break;
            case "LUMINANCE":
                currentTool = luminanceTool
                luminanceSlider.value = 1
                break
            case "HSL":
                currentTool = hslTool
                hSlider.value = 0
                sSlider.value = 0
                lSlider.value = 0
                break
            case "COLORIZE":
                currentTool = colorizeTool
                chSlider.value = 0
                csSlider.value = 1
                clSlider.value = 0
                break
            case "SHARPEN":
                currentTool = sharpenTool
                sharpSlider.value = 9
                break
            case "EDGE":
                currentTool = edgeTool
                edgeSlider.value = 0.5
                break
            case "RADIAL BLUR":
                currentTool = radialBlurTool
                hOffsetSlider.value = 0
                vOffsetSlider.value = 0
                angleBlurSlider.value = 0
                break
            case "WAVE":
                currentTool = waveTool
                break;
            default:
                break;
        }
        visibleTool()
    }

    function printToolTip(action) {
        var tip;
        switch(action) {
            case "PAINT":
                tip = "Paint on canvas"
                break;
            case "SHAPES":
                tip = "Draw fancy shapes"
                break;
            case "TEXT":
                tip = "Set text to canvas"
                break;
            case "COLORS":
                tip = "Define RGB pallete"
                break;
            case "BLUR":
                tip = "High quality blur"
                break
            case "BRIGHTNESS":
                tip = "Define brightness and contrast"
                break;
            case "LUMINANCE":
                tip = " Luminous intensity per unit area of light travelling "
                break
            case "HSL":
                tip = "Set hue, saturation and lightness levels"
                break
            case "COLORIZE":
                tip = ""
                break
            case "SHARPEN":
                tip = "Define sharpness level"
                break
            case "EDGE":
                tip = "Edge detection effect"
                break
            case "RADIAL BLUR":
                tip = "Applies directional blur in a circular direction around the items center point"
                break
            case "WAVE":
                tip = "Wave effect with amplitude and frequency todO OPIS Z QMLBOOK"
                break;
            default:
                tip = ""
                break;
        }
        textTip.text = tip
    }

    function activateTipTool() {
        for(var i = 0; i< children.length; ++i) {
            children[i].visible = false
        }
        textTip.visible = true
    }

    function visibleTool() {
        for(var i = 0; i< children.length; ++i) {
            children[i].visible = false
        }
        currentTool.visible = true
    }
}
