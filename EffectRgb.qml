import QtQuick 2.3
import QtGraphicalEffects 1.0

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
