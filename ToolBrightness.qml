import QtQuick 2.0

Tool {

    onVisibleChanged: {
        if(visible) {
            brightnessSlider.value = 0
            contrastSlider.value = 0
        }
    }

    TextTool {
        text: "brightness"
    }
    FancySlider {
        id: brightnessSlider
        from: -1
        to: 1
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
        from: -1
        to: 1
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.contrast = contrastSlider.value
        }
    }
}
