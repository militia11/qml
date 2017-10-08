import QtQuick 2.9
ShaderEffect {
    id:roots
    x:  225
    y:130
    width: sourceImage.width; height: sourceImage.height
    property variant source: sourceImage
    onVisibleChanged: {
        console.log(roots.x)
        console.log(roots.y)
    }
}

