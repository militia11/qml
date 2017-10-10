import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

import ShapesTypes 1.0
import CanvasModes 1.0

Item {
    id: root
    width: 200; height: 800
    anchors.verticalCenter: parent.verticalCenter

    property int strokeSize: toolShapes.strokeSize
    property Item currentTool: toolDraw
    property int currentShape: Shapes.RECTANGLE
    property string currentComposite: "destination-over"
    property color colorStroke: toolDraw.colorStroke
    property color colorFill: toolDraw.colorFill
    property int lineWidth: toolDraw.lineWidth

    ToolDraw {
        id: toolDraw
    }

    ToolShapes {
        id: toolShapes
    }

    ToolRgb {
        id: toolRgb
    }

    ToolBrightness {
        id: toolBrightness
    }

    ToolBlur {
        id: toolBlur
    }

    ToolLuminance {
        id: toolLuminance
    }

    ToolHsl {
        id: toolHsl
    }

    ToolColorize {
        id: toolColorize
    }

    ToolSharpen {
        id: toolSharpen
    }

    ToolEdge {
        id: toolEdge
    }

    ToolRBlur {
        id: toolRBlur
    }

    ToolWave {
        id: toolWave
    }

    ToolIsolate {
        id: toolIsolate
    }

    TextArea {
        id: textTip
        anchors.horizontalCenter: parent.horizontalCenter
        focus: false
        anchors.fill: parent
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        font.family: "Helvetica"
        font.pointSize: 15
        color: "#558C89"
        wrapMode: TextEdit.Wrap
        background: Rectangle {
            color: "transparent"
            width: parent.width
            height: parent.height
        }
    }

    function switchActiveToolbars(action) {
        canvas.mode = CanvasModes.NONE
        switch(action) {
            case "PAINT":
                currentTool = toolDraw
                canvas.mode = CanvasModes.DRAWING
                break;
            case "SHAPES":
                currentTool = toolShapes
                canvas.mode = CanvasModes.ADDSHAPES
                break;
            case "COLORS":
                currentTool = toolRgb
                break;
            case "ISOLATE":
                  currentTool = toolIsolate
                break;
            case "BLUR":
                currentTool = toolBlur
                break
            case "BRIGHTNESS":
                currentTool = toolBrightness
                break;
            case "LUMINANCE":
                currentTool = toolLuminance
                break
            case "HSL":
                currentTool = toolHsl
                break
            case "COLORIZE":
                currentTool = toolColorize
                break
            case "SHARPEN":
                currentTool = toolSharpen
                break
            case "EDGE":
                currentTool = toolEdge
                break
            case "RADIAL BLUR":
                currentTool = toolRBlur
                break
            case "WAVE":
                currentTool = toolWave
                break;
            default:
                break;
        }
        visibleTool()
    }

    function resetVideo() { toolWave.resetValues() }
    function printToolTip(action) {
        var tip;
        switch(action) {
            case "PAINT":
                tip = "Paint on canvas"
                break;
            case "SHAPES":
                tip = "Add fancy shapes"
                break;
            case "TEXT":
                tip = "Add fancy text"
                break;
            case "COLORS":
                tip = "Define RGB pallete"
                break;
            case "BLUR":
                tip = "Applies a higher quality blur effect"
                break
            case "ISOLATE":
                tip = "Isolate selected hue"
                break
            case "BRIGHTNESS":
                tip = "Define brightness and contrast of the current canvas wiev"
                break;
            case "LUMINANCE":
                tip = "Luminous intensity per unit area of light travelling "
                break
            case "HSL":
                tip = "Alters the source item colors in the HSL color space levels from orginal"
                break
            case "COLORIZE":
                tip = "Set hue, saturation and lightness space levels. Specify a desired value for each property"
                break
            case "SHARPEN":
                tip = "Define sharpness level"
                break
            case "EDGE":
                tip = "Edge detection effect. Black and white colors"
                break
            case "RADIAL BLUR":
                tip = "Applies directional blur in a circular direction around the items center point"
                break
            case "WAVE":
                tip = "Wave effect. Define frequency of the pulse and amplitude of texture coordinate"
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
