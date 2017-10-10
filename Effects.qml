import QtQuick 2.3
import QtGraphicalEffects 1.0

Item {
    property Item currentEffect: eNone

    Item {
        id: eNone
    }

    EffectGenie {
        id: eGenie
    }

    EffectIsolate {
        id: eIsolate
    }

    EffectRgb {
        id: eRgb
    }

    EffectEdge {
        id: eEdge
    }

    EffectSharpen {
        id: eSharpen
    }

    GaussianBlur {
        id: eBlur
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        radius: 0
        samples: 19
    }

    RadialBlur {
        id: eRadialBlur
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        samples: 24
        angle: 0
        verticalOffset: 0
        horizontalOffset: 0
    }

    BrightnessContrast {
        id: eBrightnessContrast
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        brightness: 0.0
        contrast: 0.0
    }

    GammaAdjust {
        id: eLuminance
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        gamma: 1
     }

    HueSaturation {
        id: eHsl
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        hue: 0
        saturation: 0
        lightness: 0
    }

    Colorize {
        id: eColorize
        width: sourceImage.width; height: sourceImage.height
        source: sourceImage
        hue: 0
        lightness: 0
        saturation: 1
    }

    EffectCurtain {
        id: eCurtain
    }

    EffectWave {
        id: eWave
    }

    function onCanvas() {
        currentEffect.x = canvas.x
        currentEffect.y = canvas.y
        currentEffect.width = canvas.width
        currentEffect.height = canvas.height
        currentEffect.visible = true
    }

    function activate() {
        canvas.canvasDataToSourceImage()
        for (var i=0; i< 10000000; i++) {
        }
        onCanvas()
    }

    function toImage() {
        if(currentEffect != eNone) {
            currentEffect.grabToImage(function(result) {
                tImage.source = result.url;
                },
                Qt.size(canvas.width, canvas.height))
            canvas.repaintImage = true;
           timers.requestPaintAfterDelay()
        }
    }

    function visibleEffect() {
        for(var i = 0; i< children.length; ++i) {
            children[i].visible = false
        }
        currentEffect.visible = true
    }

    function switchActiveEffect(effect) {
        switch(effect) {
            case "GENIE":
                currentEffect = eGenie
                break
            case "CURTAIN":
                currentEffect = eCurtain
                visibleEffect()
                onCanvas()
                return
            case "COLORS":
                currentEffect = eRgb;
                break;
            case "ISOLATE":
                currentEffect = eIsolate;
                break;
            case "BLUR":
                currentEffect = eBlur
                break
            case "BRIGHTNESS":
                currentEffect = eBrightnessContrast
                break;
            case "LUMINANCE":
                currentEffect = eLuminance
                break
            case "HSL":
                currentEffect = eHsl
                break
            case "COLORIZE":
                currentEffect = eColorize
                break
            case "SHARPEN":
                currentEffect = eSharpen
                break
            case "EDGE":
                currentEffect = eEdge
                break
            case "RADIAL BLUR":
                currentEffect = eRadialBlur
                break
            case "WAVE":
                currentEffect = eWave
                break;
            default:
                currentEffect = eNone
                break;
        }
        visibleEffect()
        activate()
    }
}

