import QtQuick 2.0

Tool {
    onVisibleChanged: {
        if(visible) {
            frequency.value = 4.2
            amplitude.value = 0.1
        }
    }

    TextTool {
        text: "frequency"
    }
    FancySlider {
        id: frequency
        from: 1
        to: 7.4
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
        from: 0.01
        to: 0.19
        value: 0.1
        onValueChanged: {
            effects.currentEffect.amplitude = amplitude.value
        }
    }
}
