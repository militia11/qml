import QtQuick 2.0

Tool {
    autoSave: false
    onVisibleChanged: {
        if(visible) {
            frequency.value = 0.0
            amplitude.value = 0.0
            effects.currentEffect.frequency = 0.0
            effects.currentEffect.amplitude = 0.0
            resetWave.opacity = 0
            videoButton.opacity = 0
        }
    }

    TextTool {
        text: "frequency"
    }
    FancySlider {
        id: frequency
        from: 0.0
        to: 7.4
        value: 4.2
        onValueChanged: {
            effects.currentEffect.frequency = frequency.value
            if(videoButton.opacity==0)
                videoButton.opacity = 1
            if(resetWave.opacity == 0) {
                resetWave.opacity = 1
            }
        }
    }

    TextTool {
        text: "amplitude"
    }
    FancySlider {
        id: amplitude
        from: 0.0
        to: 0.19
        value: 0.1
        onValueChanged: {
            effects.currentEffect.amplitude = amplitude.value
            if(videoButton.opacity==0)
                videoButton.opacity = 1
            if(resetWave.opacity == 0) {
                resetWave.opacity = 1
            }
        }
    }

    VideoButton {
        id: videoButton
        onClick: {
            effects.toImage()
            timers.delayAfterCapture()
        }
    }

    ResetButton {
        id: resetWave
        onClick: {
           resetValues()
           videoButton.opacity = 0
        }
    }

    function resetValues() {
        frequency.value = 0.0
        amplitude.value = 0.0
        resetWave.opacity = 0
    }
}
