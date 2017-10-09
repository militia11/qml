import QtQuick 2.9
import QtQuick.Controls 2.2
import ShapesTypes 1.0

Tool {
    id: root
    property int strokeSize
    property color colorFill: toolDraw.colorFill
    property color colorStroke: toolDraw.colorStroke
    spacing: 13

    Row {
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Column {
            ShapeButton {
                id: shapeRect
                checked: true
                subRecRadius : 0
                onCheckedChanged: {
                    if(checked) {
                        shapeCircle.checked = false
                        tools.currentShape = Shapes.RECTANGLE
                    }
                }
            }
        }

        Column{
            ShapeButton {
                id: shapeCircle
                subRecRadius : 16
                onCheckedChanged: {
                    if(checked) {
                        shapeRect.checked = false
                        tools.currentShape = Shapes.ELISPE
                    }
                }

            }
        }
    }

    TextTool {
        text: "frame size"
    }

    FancySlider {
        id: frameSlider
        from: 1
        to: 45
        value: 1
        enabled: true
        onValueChanged: {
            root.strokeSize = frameSlider.value
        }
    }

    Row {
        spacing: 10
        Column {
            TextTool {
                text: "fill"
            }
            ColorButton {
                color: colorFill
                onClicked: {colorDialogFill.open()}
            }
            ColorSelectDialog {
                id: colorDialogFill
                onAccepted: {
                    root.colorFill = colorDialogFill.color
                    close()
                }
            }
        }

        Column{
            TextTool {
                text: "frame"
            }
            ColorButton {
                color: colorStroke
                onClicked: colorDialogFrame.open()
            }

            ColorSelectDialog {
                id: colorDialogFrame
                onAccepted: {
                    root.colorStroke = colorDialogFrame.color
                    close()
                }
            }
        }

        Column {
            TextTool {
                text: "back"
            }
            ColorButton {
                color: canvasBackground.colour
                onClicked: colorDialogBackground.open()
            }
            ColorSelectDialog {
                id: colorDialogBackground
                onAccepted: {
                    canvasBackground.colour = colorDialogBackground.color
                    canvas.requestPaint()
                    close()
                }
            }
        }
    }

    TextTool {
        text: "composition"
    }
    ComboBox {
        id: comboComposite
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter

        model: [ 'destination-over', 'lighter',
            'qt-multiply', 'qt-screen', 'qt-overlay', 'qt-darken',
            'qt-lighten', 'qt-color-dodge', 'qt-color-burn',
            'qt-hard-light', 'qt-soft-light', 'qt-difference',
            'qt-exclusion' ]
        onCurrentTextChanged: currentComposite = comboComposite.currentText

        delegate: ItemDelegate {
            width: comboComposite.width
            contentItem: Text {
                text: modelData.replace("qt", "").replace("-", " ").replace("-", " ").toUpperCase()
                color: "#558C89"
                font: comboComposite.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            highlighted: comboComposite.highlightedIndex === index
        }

        indicator: Canvas {
            id: canvas
            x: comboComposite.width - width - comboComposite.rightPadding
            y: comboComposite.topPadding + (comboComposite.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            Connections {
                target: comboComposite
                onPressedChanged: canvas.requestPaint()
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = comboComposite.pressed ?  Qt.lighter("#74AFAD", 1.22) : Qt.lighter("#558C89", 1.04)
                context.fill();
            }
        }

        contentItem: Text {
            leftPadding: 0
            rightPadding: comboComposite.indicator.width + comboComposite.spacing

            text: comboComposite.displayText.replace("qt", "").replace("-", " ").replace("-", " ").toUpperCase()
            font: comboComposite.font
            color: comboComposite.pressed ? "#D9853B" : Qt.lighter("#74AFAD", 1.3)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 40
            color: Qt.lighter("#74AFAD", 1.02)
            border.color: comboComposite.pressed ?  "#D9853B" :  Qt.lighter("#74AFAD", 1.3)
            border.width: comboComposite.visualFocus ? 2 : 1
            radius: 2
        }

        popup: Popup {
            y: comboComposite.height - 1
            width: comboComposite.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: comboComposite.popup.visible ? comboComposite.delegateModel : null
                currentIndex: comboComposite.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                border.color: Qt.lighter("#558C89", 1.1)
                color: Qt.lighter("#74AFAD", 1.1)
                radius: 2
            }
        }
    }
}
