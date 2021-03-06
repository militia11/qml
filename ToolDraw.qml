import QtQuick 2.3
import QtQuick.Controls 2.2

import CanvasModes 1.0

Tool {
    id: root
    spacing: 5
    onVisibleChanged: {}

    property color colorStroke: "#558C89"
    property color colorFill: "lightblue"
    property int lineWidth: 6

    TextTool {
        text: "size"
    }
    FancySlider {
        id: sliderCanvasBrush
        from: 0.5
        to: 30
        value: 2.5
        onValueChanged: {
            root.lineWidth = sliderCanvasBrush.value
        }
    }

    Repeater {
        model: ["lightblue", "#558C89", "blue",
            "lightgreen", "#99CC00", "green", "gold",
            "#FFBB33","#FF4444" , "red", "black"]
        ColorSquare {
            color: modelData
            active: root.colorStroke === color
            onClicked: {
                root.colorStroke = color
                canvas.mode = CanvasModes.DRAWING
                eraserButton.checked = false
            }
        }
    }

    Button {
        id: eraserButton
        anchors.horizontalCenter: parent.horizontalCenter
        width: 75; height: 55
        checkable: true
        background:
            Rectangle {
             id: recInButtonStyle
                color: eraserButton.checked ? Qt.lighter("#74AFAD", 1.45) : "transparent"
                border.width: eraserButton.hovered || eraserButton.checked ? 3 : 0
                border.color: Qt.lighter("#74AFAD", 1.13)
                radius: 5
            }

            Image {
                anchors.fill: recInButtonStyle
                source: "qrc:///images/eraser.png"

           }
        onClicked: {
            if (eraserButton.checked) {
                root.colorStroke = "white"
                canvas.mode = CanvasModes.RUBBER
            }
        }
    }
}
