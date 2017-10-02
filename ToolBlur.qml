import QtQuick 2.0

Tool {
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
