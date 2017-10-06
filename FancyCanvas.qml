import QtQuick 2.0
import ShapesTypes 1.0
import CanvasModes 1.0

Canvas {
    id: root
    width: parent.width - 20; height: parent.height - 20
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 10
    anchors.topMargin: 10

    property int mode: CanvasModes.NONE
    property bool copyFirst: false
    property bool putLast: false
    property real lastX
    property real lastY
    property color colorStroke: tools.colorStroke
    property color colorFill: tools.colorFill
    property real lineWidth: 2.5
    property real shapeWidth: 0
    property real shapeHeight: 0
    property int shapeType: tools.currentShape
    property bool repaintImage: false
    property bool loadImage: false
    property real strokeSize: tools.strokeSize

    Image {
        id: tempImage
        visible: false
        opacity: 0.7
    }
    onPaint: {
        var ctx = getContext('2d')
        if (canvas.loadImage) {
            canvas.loadImageInCanvas(ctx)
        }

        if (canvas.repaintImage) {
            canvas.repaintImageInCanvas(ctx)
        }

        if (mode == CanvasModes.DRAWING) {
            canvas.drawing(ctx)
        } else if (mode == CanvasModes.ADDSHAPES) {
            drawShape(ctx)
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent

        onPressed: {
            if(mode != CanvasModes.NONE) {
                canvas.lastX = mouseX
                canvas.lastY = mouseY
                if(mode == CanvasModes.ADDSHAPES || mode == CanvasModes.RUBBER) {
                    canvas.copyFirst = true
                    canvas.requestPaint()
                    tempImage.update()
                    tempImage.visible = true
                }
            }
        }

        onReleased: {
            if(mode == CanvasModes.ADDSHAPES || mode == CanvasModes.RUBBER) {
                canvas.shapeHeight = 0
                canvas.shapeWidth = 0
                canvas.putLast = true
                canvas.requestPaint()
                tempImage.visible = false
            }
        }

        onPositionChanged: {
            if(mode != CanvasModes.NONE) {
                if(mode == CanvasModes.ADDSHAPES || mode == CanvasModes.RUBBER) {
                     canvas.shapeWidth = mouseX - canvas.lastX
                     canvas.shapeHeight = mouseY - canvas.lastY
                }
                canvas.requestPaint()
            }
        }
    }

    function drawShape(ctx) {
        ctx.fillStyle = canvas.colorFill
        ctx.strokeStyle = colorStroke
        if(canvas.copyFirst) {
            var url = canvas.toDataURL('image/png')
            tempImage.source = url
            canvas.copyFirst = false
        } else if(canvas.putLast) {
            ctx.globalCompositeOperation = tools.currentComposite
            ctx.drawImage(tempImage, 0, 0)
            canvas.putLast = false
        } else {
            ctx.beginPath()
            ctx.lineWidth = canvas.strokeSize
            ctx.moveTo(lastX, lastY)
            ctx.clearRect(0, 0, canvas.width, canvas.height)
            if (canvas.shapeType === Shapes.RECTANGLE)
                ctx.rect(canvas.lastX, canvas.lastY, canvas.shapeWidth, canvas.shapeHeight)
            else if (canvas.shapeType === Shapes.ELISPE)
                ctx.ellipse(canvas.lastX, canvas.lastY, canvas.shapeWidth, canvas.shapeHeight)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()
        }
    }

    function drawing(ctx) {
        ctx.lineWidth = canvas.lineWidth
        ctx.strokeStyle = canvas.colorStroke
        ctx.beginPath()
        ctx.moveTo(lastX, lastY)
        lastX = area.mouseX
        lastY = area.mouseY
        ctx.lineTo(lastX, lastY)
        ctx.stroke()
    }

    function canvasDataToSourceImage() {
        var url = canvas.toDataURL('image/png')
        sourceImage.source = url
        //console.log(url)
    }

    function loadImageInCanvas(context) {
        context.drawImage(sourceImage, 0, 0)
        canvas.loadImage = false
        context.save()
    }

    function repaintImageInCanvas(context) {
        context.drawImage(tImage, 0, 0)
        context.save()
        canvas.repaintImage = false
    }
}
