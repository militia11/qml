function getCanvasDataToSourceImage() {
    var url = canvas.toDataURL('image/png')
    sourceImage.source = url
}

function sheZaslonCanvas(she) {
    she.anchors.fill = canvas
    she.visible = true
}

function sheActivate(she) {
    getCanvasDataToSourceImage()
    for (var i=0; i< 10000000;i++) {
    }
    sheZaslonCanvas(she)
}

function sheApplyToCanvas(she) {
    getCanvasDataToSourceImage()
    sheToTargetImage(she)
}

function sheToTargetImage(she) {
    if(she.grabToImage(function(result) {
        targetImage.source = result.url;
        },
        Qt.size(canvas.width, canvas.height))) {
    } else {
        console.log("grabDone: " + grabDone)
    }
}

function switchActiveToolbars(row) {
    switch(row) {
        case paintTools:
            paintTools.visible = true;
            sheWave.visible = false
            waveTool.visible = false
            blurTool.visible = false
            rgbTool.visible = false
            canvas.paintMode = true;
            break;
        case rgbTool:
            blurTool.visible = false
            rgbTool.visible = true
            sheWave.visible = false
            waveTool.visible = false
            paintTools.visible = false;
            canvas.paintMode = false
            sheRgb.red = 1.0
            sheRgb.green = 1.0
            sheRgb.blue = 1.0
            break;
        case waveTool:
            waveTool.visible = true;
            blurTool.visible = false
            canvas.paintMode = false
            paintTools.visible = false;
            rgbTool.visible = false;
            break;
        case blurTool:
            waveTool.visible = false;
            canvas.paintMode = false
            paintTools.visible = false;
            rgbTool.visible = false;
            blurTool.visible = true
            canvas.paintMode = false
            break
        case none:
            blurTool.visible = false
            rgbTool.visible = false
            sheWave.visible = false
            waveTool.visible = false
            paintTools.visible = false;
            canvas.paintMode = false
            break;
    }
}

function loadImageInCanvas(context) {
    context.drawImage(sourceImage, 0, 0)
    context.save()
}

function repaintImageInCanvas(context) {
    context.drawImage(targetImage, 0, 0)
    context.save()
}
