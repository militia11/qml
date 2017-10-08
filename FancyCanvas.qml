import QtQuick 2.0
import QtQuick.Particles 2.0

import CanvasModes 1.0
import ShapesTypes 1.0

Canvas {
    property int mode: CanvasModes.NONE
    property bool copyFirst: false
    property bool putLast: false
    property real lastX
    property real lastY
    property color colorStroke: tools.colorStroke
    property color colorFill: tools.colorFill
    property real lineWidth: tools.lineWidth
    property real shapeWidth: 0
    property real shapeHeight: 0
    property int shapeType: tools.currentShape
    property bool repaintImage: false
    property bool loadImage: false
    property real strokeSize: tools.strokeSize
    property bool fillWhite: true

    Image {
        id: tempImage
        visible: false
        opacity: 0.7
    }
    onPaint: {
        var ctx = getContext('2d')
        if (canvas.loadImage) {
            ctx.clearRect(0, 0, canvas.width, canvas.height)
            canvas.loadImageInCanvas(ctx)
        }

        if (canvas.repaintImage) {
            canvas.repaintImageInCanvas(ctx)
        }

        if(canvas.fillWhite) {
            ctx.fillStyle = "white"
            ctx.fillRect(0, 0, canvas.width, canvas.height)
            fillWhite = false
        }

        if (mode == CanvasModes.DRAWING) {
            ctx.strokeStyle = canvas.colorStroke
            canvas.drawing(ctx)
        } else if (mode == CanvasModes.ADDSHAPES) {
            drawShape(ctx)
        } else if(mode == CanvasModes.RUBBER) {
            ctx.strokeStyle = canvasBackground.color
            canvas.drawing(ctx)
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent

        onPressed: {
            if(mode != CanvasModes.NONE) {
                canvas.lastX = mouseX
                canvas.lastY = mouseY
                if(mode == CanvasModes.ADDSHAPES) {
                    canvas.copyFirst = true
                    canvas.requestPaint()
                    tempImage.update()
                    tempImage.visible = true
                }
            }
        }

        onReleased: {
            if (mode != CanvasModes.NONE) {
                if(mode == CanvasModes.ADDSHAPES) {
                    particlesEmmiterShapes.burst(110)
                    canvas.shapeHeight = 0
                    canvas.shapeWidth = 0
                    canvas.putLast = true
                    canvas.requestPaint()
                    tempImage.visible = false
                }
            }
        }

        onPositionChanged: {
            if(mode != CanvasModes.NONE) {
                if(mode == CanvasModes.ADDSHAPES) {
                     canvas.shapeWidth = mouseX - canvas.lastX
                     canvas.shapeHeight = mouseY - canvas.lastY
                }
                canvas.requestPaint()
            }
        }
    }

    ParticleSystem {
        x: area.mouseX
        y: area.mouseY
        ImageParticle {
            source: "qrc:///images/star.png"
            color: tools.colorFill
            rotationVelocityVariation: 360
        }

        Emitter {
            id: particlesEmmiterShapes
            anchors.centerIn: parent
            emitRate: 0
            lifeSpan: 790
            velocity: AngleDirection {angleVariation: 360; magnitude: 199; magnitudeVariation: 130}
            size: 21
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

    function loadImageInCanvas(ctx) {
        var startX = 0
        var startY = 0
        if(sourceImage.width < canvas.width) {
            var spaceWidth = canvas.width - sourceImage.width
            startX = spaceWidth / 2
        }
        if(sourceImage.height < canvas.height) {
            var spaceHeight = canvas.height - sourceImage.height
            startY = spaceHeight / 2
        }
        ctx.drawImage(sourceImage, startX, startY)
        canvas.loadImage = false
        canvas.height = sourceImage.height
        canvas.width = sourceImage.width
        console.log(canvas.x)
        console.log(canvas.y)
    }

    function repaintImageInCanvas(context) {
        context.drawImage(tImage, 0, 0)
        context.save()
        canvas.repaintImage = false
    }
}
