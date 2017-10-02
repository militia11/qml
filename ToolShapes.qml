import QtQuick 2.0
import QtQuick.Controls 1.4
Tool {
    spacing: 5
    onVisibleChanged: {}

    ToolButton {
        text: "elipse"
        onClicked: {
            currentShape = Shapes.ELISPE
        }
    }

    TextTool {
        text: "fill"
    }
    ColorButton {
        color: colorFill
        onClicked: {colorDialogFill.open()}
    }

    TextTool {
        text: "frame"
    }
    ColorButton {
        color: colorStroke
        onClicked: colorDialogFrame.open()
    }
    FancySlider {
        id: frameSlider
        minimumValue: 0
        maximumValue: 45
        value: 0
        enabled: true
        onValueChanged: {
            root.strokeSize = frameSlider.value
        }
    }

    ColorSelectDialog {
        id: colorDialogFill
        onAccepted: {
            root.colorFill = colorDialogFill.color
            close()
        }
    }

    ColorSelectDialog {
        id: colorDialogFrame
        onAccepted: {
            root.colorStroke = colorDialogFill.color
            close()
        }
    }

    ComboBox {
        id: comboComposite
        width: 200
        model: [ 'destination-over', 'lighter',
            'qt-multiply', 'qt-screen', 'qt-overlay', 'qt-darken',
            'qt-lighten', 'qt-color-dodge', 'qt-color-burn',
            'qt-hard-light', 'qt-soft-light', 'qt-difference',
            'qt-exclusion' ]
        onCurrentTextChanged: currentComposite = comboComposite.currentText
    }

}
