import QtQuick 2.0

Tool {
    property color paintColor: "red"

    Repeater {
        model: ["red", "#04e824", "blue"]

        FancySlider {
            id: slider
            maineColor: modelData
            minimumValue: 0.0
            maximumValue: 2.0
            value: 1.0
            enabled: true

            onVisibleChanged: {
                if (visible) {
                    slider.value = 1.0
                }
            }

            onValueChanged: {
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
}
