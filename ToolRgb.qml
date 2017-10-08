import QtQuick 2.0

Tool {
    property color paintColor: "red"
    Repeater {
        id: repeaterColors
        model: ["red", "#04e824", "blue"]

        FancySlider {
            id: slider
            maineColor: modelData
            from: 0.0
            to: 2.0
            value: 1.0
            enabled: true

            onVisibleChanged: {
                if (visible) {
                    slider.value = 1.0
                    resetRgb.opacity = 0
                }
            }

            onValueChanged: {
                if(resetRgb.opacity==0)
                    resetRgb.opacity = 1
                switch(modelData) {
                    case "red":
                        effects.currentEffect.red = slider.value
                        break;
                    case "#04e824":
                        effects.currentEffect.green = slider.value
                        break;
                    case "blue":
                        effects.currentEffect.blue = slider.value
                        break;
                }
            }
        }
    }

    ResetButton {
        id: resetRgb
        onReset: {
            repeaterColors.itemAt(0).value = 1.0
            repeaterColors.itemAt(1).value = 1.0
            repeaterColors.itemAt(2).value = 1.0
        }
    }
}
