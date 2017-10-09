import QtQuick 2.0

Tool {
    autoSave: false
    onVisibleChanged: {
        if(visible) {
            chSlider.value = 0
            csSlider.value = 1
            clSlider.value = 0
            applyColorize.opacity = 0
        }
    }

    TextTool {
        text: "hue"
    }
    FancySlider {
        id: chSlider
        from: 0
        to: 1
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.hue = chSlider.value
            if(applyColorize.opacity == 0)
                applyColorize.opacity = 1
        }
    }

    TextTool {
        text: "saturation"
    }
    FancySlider {
        id: csSlider
        from: 0
        to: 1
        value: 1
        enabled: true
        onValueChanged: {
            effects.currentEffect.saturation = csSlider.value
            if(applyColorize.opacity == 0)
                applyColorize.opacity = 1
        }
    }

    TextTool {
        text: "lightness"
    }
    FancySlider {
        id: clSlider
        from: -1
        to: 1
        value: 0
        enabled: true
        onValueChanged: {
            effects.currentEffect.lightness = clSlider.value
            if(applyColorize.opacity == 0)
                applyColorize.opacity = 1
        }
    }

    ApplyButton {
        id: applyColorize
        onClick: {
             effects.toImage()
        }
    }
}
