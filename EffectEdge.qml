import QtQuick 2.3
import QtGraphicalEffects 1.0

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
