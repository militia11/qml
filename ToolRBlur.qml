import QtQuick 2.0

Tool {
    onVisibleChanged: {
        if(visible) {
            hOffsetSlider.value = 0
            vOffsetSlider.value = 0
            angleBlurSlider.value = 0
            resetRBlur.opacity = 0
        }
    }

    TextTool {
        text: "angle"
    }
    FancySlider {
        id: angleBlurSlider
        from: 0
        to: 30
        value: 0
        onValueChanged: {
            effects.currentEffect.angle = angleBlurSlider.value
            if(resetRBlur.opacity == 0)
                resetRBlur.opacity = 1
        }
    }

    TextTool {
        text: "horizontal offset"
    }
    FancySlider {
        id: hOffsetSlider
        from: -100
        to: 100
        value: 0
        onValueChanged: {
            effects.currentEffect.verticalOffset = hOffsetSlider.value
            if(resetRBlur.opacity == 0)
                resetRBlur.opacity = 1
        }
    }

    TextTool {
        text: "vertical offset"
    }
    FancySlider {
        id: vOffsetSlider
        from: -100
        to: 100
        value: 0
        onValueChanged: {
            effects.currentEffect.verticalOffset = vOffsetSlider.value
            if(resetRBlur.opacity == 0)
                resetRBlur.opacity = 1
        }
    }

    ResetButton {
        id: resetRBlur
        onReset: {
            angleBlurSlider.value = 0
            hOffsetSlider.value = 0
            vOffsetSlider.value = 0
        }

    }
}
