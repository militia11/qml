import QtQuick 2.0
import QtQuick.Particles 2.0

import CanvasModes 1.0
import ShapesTypes 1.0

Canvas {
    property int mode: CanvasModes.NONE
    property bool copyFirst: false
    property bool putLast: false
    property bool resized: false
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
        if (loadImage) {
            ctx.clearRect(0, 0, width, height)
            loadImageInCanvas(ctx)
            return
        }

        if (repaintImage) {
            repaintImageInCanvas(ctx)
            return
        }

        if(fillWhite) {
            ctx.fillStyle = "white"
            ctx.fillRect(0, 0, width, height)
            fillWhite = false
            return
        }

        if (mode == CanvasModes.DRAWING) {
            ctx.strokeStyle = colorStroke
            drawing(ctx)
        } else if (mode == CanvasModes.ADDSHAPES) {
            drawShape(ctx)
        } else if(mode == CanvasModes.RUBBER) {
            ctx.strokeStyle = canvasBackground.color
            drawing(ctx)
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent

        onPressed: {
            if(mode != CanvasModes.NONE) {
                lastX = mouseX
                lastY = mouseY
                if(mode == CanvasModes.ADDSHAPES) {
                    copyFirst = true
                    requestPaint()
                    tempImage.update()
                    tempImage.visible = true
                }
            }
        }

        onReleased: {
            if (mode != CanvasModes.NONE) {
                if(mode == CanvasModes.ADDSHAPES) {
                    particlesEmmiterShapes.burst(110)
                    shapeHeight = 0
                    shapeWidth = 0
                    putLast = true
                    requestPaint()
                    tempImage.visible = false
                }
            }
        }

        onPositionChanged: {
            if(mode != CanvasModes.NONE) {
                if(mode == CanvasModes.ADDSHAPES) {
                     shapeWidth = mouseX - lastX
                     shapeHeight = mouseY - lastY
                }
                requestPaint()
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
        ctx.fillStyle = colorFill
        ctx.strokeStyle = colorStroke
        if(copyFirst) {
            var url = toDataURL('image/png')
            tempImage.source = url
            copyFirst = false
        } else if(putLast) {
            ctx.globalCompositeOperation = tools.currentComposite
            ctx.drawImage(tempImage, 0, 0)
            putLast = false
        } else {
            ctx.beginPath()
            ctx.lineWidth = strokeSize
            ctx.moveTo(lastX, lastY)
            ctx.clearRect(0, 0, width, height)
            if (shapeType === Shapes.RECTANGLE)
                ctx.rect(lastX, lastY, shapeWidth, shapeHeight)
            else if (shapeType === Shapes.ELISPE)
                ctx.ellipse(lastX, lastY, shapeWidth, shapeHeight)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()
        }
    }

    function drawing(ctx) {
        ctx.lineWidth = lineWidth
        ctx.beginPath()
        ctx.moveTo(lastX, lastY)
        lastX = area.mouseX
        lastY = area.mouseY
        ctx.lineTo(lastX, lastY)
        ctx.stroke()
        console.log("sourceImage"+ sourceImage.width)
        console.log("res"+ canvas.width)
    }

    function canvasDataToSourceImage() {
        console.log("canvas::canvasDataToSourceImage")
        var url = toDataURL('image/png')
        sourceImage.source = url
        //console.log(url)
    }

    function loadImageInCanvas(ctx) {
        var startX = 0
        var startY = 0
        if(sourceImage.width < width) {
            var spaceWidth = width - sourceImage.width
            startX = spaceWidth / 2
            resized = true
        }
        if(sourceImage.height < height) {
            var spaceHeight = height - sourceImage.height
            startY = spaceHeight / 2
            resized = true
        }
        if (resized) {
            canvas.height = sourceImage.height
            canvas.width = sourceImage.width
            resized = false
            timers.requestPaintAfterDelay()
        } else {
            ctx.drawImage(sourceImage, startX, startY)
            loadImage = false
        }
    }

    function repaintImageInCanvas(context) {
        context.drawImage(tImage, 0, 0)
        context.save()
        repaintImage = false
    }
}
