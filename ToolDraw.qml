import QtQuick 2.0

import QtQuick 2.0

Tool {
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
            "lightgreen", "#99CC00", "green","yellow",
            "gold", "#FFBB33","#FF4444" , "red", "black"]
        ColorSquare {
            color: modelData
            active: root.colorStroke === color
            onClicked: {
                root.colorStroke = color
            }
        }
    }
}
