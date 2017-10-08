import QtQuick 2.0

Tool {
    TextTool {
        text: "radius"
    }
    onVisibleChanged: {
        if(visible) {
            blurSlider.value = 0
            resetBlur.opacity = 0
        }
    }

    FancySlider {
        id: blurSlider
        from: 0
        to: 35
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.radius = blurSlider.value
            if(resetBlur.opacity == 0)
                resetBlur.opacity = 1
        }
    }

    ResetButton {
        id: resetBlur
        onReset: blurSlider.value = 0
    }
}
