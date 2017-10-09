import QtQuick 2.6
import QtQuick.Controls 2.1

Tool {
    autoSave: false
    onVisibleChanged: {
        if(visible) {
            sharpSlider.value = 9
            applySharpness.opacity = 0
        }
    }
    TextTool {
        text: "sharpness"
    }
    FancySlider {
        id: sharpSlider
        from: 0
        to: 18
        value: 9
        onValueChanged: {
            if(applySharpness.opacity == 0)
                applySharpness.opacity = 1
            effects.currentEffect.amount = sharpSlider.value
        }
    }

    ApplyButton {
        id: applySharpness
        onClick: {
            effects.toImage()
        }
    }
}

