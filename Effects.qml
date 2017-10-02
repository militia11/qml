import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2

Item {
    property Item currentEffect: eNone
    Item {
        id: eNone
    }

    Effect {
        id: eRgb
        property real red: 1.0
        property real green: 1.0
        property real blue: 1.0
        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform lowp float red;
            uniform lowp float green;
            uniform lowp float blue;
            void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(red, green, blue, 1.0) * qt_Opacity;
            }"
    }

    Effect {
        id: eEdge
        property real mixLevel: 0.5
        property real targetSize: 250 - (200 * mixLevel) // TODO: fix ...
        property real resS: targetSize
        property real resT: targetSize
        fragmentShader: "
            uniform float mixLevel;
            uniform float resS;
            uniform float resT;

            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            varying vec2 qt_TexCoord0;

            void main()
            {
                vec2 uv = qt_TexCoord0.xy;
                vec4 c = vec4(0.0);
                    vec2 st = qt_TexCoord0.st;
                    vec3 irgb = texture2D(source, st).rgb;
                    vec2 stp0 = vec2(1.0 / resS, 0.0);
                    vec2 st0p = vec2(0.0       , 1.0 / resT);
                    vec2 stpp = vec2(1.0 / resS, 1.0 / resT);
                    vec2 stpm = vec2(1.0 / resS, -1.0 / resT);
                    const vec3 W = vec3(0.2125, 0.7154, 0.0721);
                    float i00   = dot(texture2D(source, st).rgb, W);
                    float im1m1 = dot(texture2D(source, st-stpp).rgb, W);
                    float ip1p1 = dot(texture2D(source, st+stpp).rgb, W);
                    float im1p1 = dot(texture2D(source, st-stpm).rgb, W);
                    float ip1m1 = dot(texture2D(source, st+stpm).rgb, W);
                    float im10  = dot(texture2D(source, st-stp0).rgb, W);
                    float ip10  = dot(texture2D(source, st+stp0).rgb, W);
                    float i0m1  = dot(texture2D(source, st-st0p).rgb, W);
                    float i0p1  = dot(texture2D(source, st+st0p).rgb, W);
                    float h = -1.0*im1p1 - 2.0*i0p1 - 1.0*ip1p1 + 1.0*im1m1 + 2.0*i0m1 + 1.0*ip1m1;
                    float v = -1.0*im1m1 - 2.0*im10 - 1.0*im1p1 + 1.0*ip1m1 + 2.0*ip10 + 1.0*ip1p1;
                    float mag = 1.0 - length(vec2(h, v));
                    vec3 target = vec3(mag, mag, mag);
                    c = vec4(target, 1.0);
                gl_FragColor = qt_Opacity * c;
            }"
    }

    Effect {
        id: eSharpen
        property real amount: 9
        fragmentShader: "
            uniform float amount;
            const float step_w = 0.0015625;
            const float step_h = 0.0027778;

            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            varying vec2 qt_TexCoord0;

            vec3 sharpen(vec3 t1, vec3 t2, vec3 t3, vec3 t4, vec3 t5, vec3 t6, vec3 t7, vec3 t8, vec3 t9)
            {
                return -t1 - t2 - t3 - t4 + amount * t5 - t6 - t7 - t8 - t9;
            }

            void main()
            {
                vec2 uv = qt_TexCoord0.xy;
                vec3 t1 = texture2D(source, vec2(uv.x - step_w, uv.y - step_h)).rgb;
                vec3 t2 = texture2D(source, vec2(uv.x, uv.y - step_h)).rgb;
                vec3 t3 = texture2D(source, vec2(uv.x + step_w, uv.y - step_h)).rgb;
                vec3 t4 = texture2D(source, vec2(uv.x - step_w, uv.y)).rgb;
                vec3 t5 = texture2D(source, uv).rgb;
                vec3 t6 = texture2D(source, vec2(uv.x + step_w, uv.y)).rgb;
                vec3 t7 = texture2D(source, vec2(uv.x - step_w, uv.y + step_h)).rgb;
                vec3 t8 = texture2D(source, vec2(uv.x, uv.y + step_h)).rgb;
                vec3 t9 = texture2D(source, vec2(uv.x + step_w, uv.y + step_h)).rgb;
                vec3 col = sharpen(t1, t2, t3, t4, t5, t6, t7, t8, t9);
                gl_FragColor = qt_Opacity * vec4(col, 1.0);
            }"
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

    ShaderEffect {
        id: eWave
        width: sourceImage.width; height: sourceImage.height
        property variant source: sourceImage
        property real frequency: 4.2
        property real amplitude: 0.1
        property real time: 0.0
        NumberAnimation on time {
            from: 0; to: Math.PI*2; duration: 1000; loops: Animation.Infinite
        }

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform highp float frequency;
            uniform highp float amplitude;
            uniform highp float time;
            void main() {
                highp vec2 pulse = sin(time - frequency * qt_TexCoord0);
                highp vec2 coord = qt_TexCoord0 + amplitude * vec2(pulse.x, -pulse.x);
                gl_FragColor = texture2D(source, coord) * qt_Opacity;
            }"
    }


    function onCanvas() {
        canvas.anchors.fill = currentEffect
        currentEffect.visible = true
    }

    function activate() {
        canvas.canvasDataToSourceImage()
        for (var i=0; i< 10000000; i++) {
        }
        onCanvas()
    }

    function toImage() {
        currentEffect.grabToImage(function(result) {
            sourceImage.source = result.url;
            },
            Qt.size(canvas.width, canvas.height))
    }

    function visibleEffect() {
        for(var i = 0; i< children.length; ++i) {
            children[i].visible = false
        }
        currentEffect.visible = true
    }

    function switchActiveEffect(effect) {
        switch(effect) {
            case "EFFECTS":
            case "PAINT":
            case "SHAPES":
                currentEffect = eNone
                break;
            case "COLORS":
                currentEffect = eRgb;
                currentEffect.red = 1.0
                currentEffect.green = 1.0
                currentEffect.blue = 1.0
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

