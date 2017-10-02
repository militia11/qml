import QtQuick 2.0

Tool {

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
