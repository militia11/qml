import QtQuick 2.0

Tool {
    onVisibleChanged: {
        if(visible) {
            hSlider.value = 0
            sSlider.value = 0
            lSlider.value = 0
        }
    }

    TextTool {
        text: "hue"
    }
    FancySlider {
        id: hSlider
        from: -1
        to: 1
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.hue = hSlider.value
        }
    }

    TextTool {
        text: "saturation"
    }
    FancySlider {
        id: sSlider
        from: -1
        to: 1
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.saturation = sSlider.value
        }
    }

    TextTool {
        text: "lightness"
    }
    FancySlider {
        id: lSlider
        from: -1
        to: 1
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.lightness = lSlider.value
        }
    }
}
