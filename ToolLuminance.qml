import QtQuick 2.3

Tool {
    onVisibleChanged: {
        if(visible) {
            luminanceSlider.value = 1
            resetLuminance.opacity = 0
        }
    }

    TextTool {
        text: "gamma"
    }
    FancySlider {
        id: luminanceSlider
        width: 155;
        from: 0
        to: 2
        value: 1
        enabled: true
        onValueChanged: {
            effects.currentEffect.gamma = luminanceSlider.value
            if(resetLuminance.opacity == 0) {
                resetLuminance.opacity = 1
            }
        }
    }

    ResetButton {
        id: resetLuminance
        onReset: luminanceSlider.value = 1
    }
}
