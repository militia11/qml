import QtQuick 2.0

Tool {
    onVisibleChanged: {
        if(visible) {
            edgeSlider.value = 0.5
            applyEdge.opacity = 0
        }
    }

    TextTool {
        text: "threshold"
    }
    FancySlider {
        id: edgeSlider
        from: 0
        to: 1
        value: 0.5
        onValueChanged: {
            effects.currentEffect.mixLevel = edgeSlider.value
            if(applyEdge.opacity == 0)
                 applyEdge.opacity = 1
        }
    }

    ApplyButton {
        id: applyEdge
        onAccept: {

        }
    }
}
