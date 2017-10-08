import QtQuick 2.9
ShaderEffect {
    id:roots
    width: sourceImage.width; height: sourceImage.height
    property variant source: sourceImage
    onVisibleChanged: {
        console.log(roots.x)
        console.log(roots.y)
    }
}

