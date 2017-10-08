import QtQuick 2.0

Tool {
    TextTool {
        text: "font size"
    }
    onVisibleChanged: {
        if(visible) {
            //fontSizeSlider.value = 0
        }
    }

    FancySlider {
        id: fontSizeSlider
        minimumValue: 0
        maximumValue: 35
        value: 0
        enabled: true
        onValueChanged: {
           //effects.currentEffect.radius = blurSlider.value
        }
    }
}

