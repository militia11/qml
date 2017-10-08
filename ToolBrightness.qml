import QtQuick 2.0

Tool {
    onVisibleChanged: {
        if(visible) {
            brightnessSlider.value = 0
            contrastSlider.value = 0
            resetBrightness.opacity = 0
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
            if(resetBrightness.opacity==0)
                resetBrightness.opacity = 1
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
            if(resetBrightness.opacity==0)
                resetBrightness.opacity = 1
        }
    }

    ResetButton {
        id: resetBrightness
        onReset: {
            brightnessSlider.value = 0
            contrastSlider.value = 0
        }
    }
}
