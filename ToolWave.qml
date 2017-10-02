import QtQuick 2.0

Tool {
    onVisibleChanged: {}

    TextTool {
        text: "frequency"
    }
    FancySlider {
        id: frequency
        minimumValue: 1
        maximumValue: 7.4
        value: 4.2
        onValueChanged: {
            effects.currentEffect.frequency = frequency.value
        }
    }

    TextTool {
        text: "amplitude"
    }
    FancySlider {
        id: amplitude
        minimumValue: 0.01
        maximumValue: 0.19
        value: 0.1
        onValueChanged: {
            effects.currentEffect.amplitude = amplitude.value
        }
    }
}
