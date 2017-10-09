import QtQuick 2.9

Tool {
    TextTool {
        text: "hue"
    }
    onVisibleChanged: {
        if(visible) {
            hSlider.value = 0
        }
    }

    FancySlider {
        id: hSlider
        from: 0
        to: 35
        value: 0
        enabled: true
        onValueChanged: {
           //effects.currentEffect.radius = blurSlider.value
        }
    }
}

