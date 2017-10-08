import QtQuick 2.3

Item {
    id: root
    width: 190; height: parent.height
    state: "expanded"

    Rectangle {
        id: showMenuButton
        x: -27
        width: 47;  height: 50
        anchors {
            top: parent.top
            topMargin: 0
            right: parent.left
            rightMargin: -20
        }
        radius: 10
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 1000
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                tools.visible = false
                root.state = "expanded"
            }
        }
    }

    Column {
        id: container
        x: 0
        width: 190
        height: 412
        anchors.verticalCenter: parent.verticalCenter
        spacing: 50

        MainButton {
            id: load
            width: 145
            iconSource: "qrc:///images/load.png"
            onClicked: {
                imageDialog.open()
            }
        }

        MainButton {
            id: save
            iconSource: "qrc:///images/save.png"
            onClicked:
                effects.switchActiveEffect("GENIE")
        }

        MainButton {
            id: camera
            checkable: true
            iconSource: "qrc:///images/camera.png"
            onClicked: {
                camera.checked = true
                loaderCamera.source = "FancyCamera.qml"
            }
        }
    }

    states: [
        State {
            name: "slim"
            PropertyChanges {
                target: load
                opacity: 0
            }
            PropertyChanges {
                target: save
                opacity: 0
            }

            PropertyChanges {
                target: camera
                opacity: 0
            }

            PropertyChanges {
                target: showMenuButton
                opacity: 1
            }
        },
        State {
            name: "expanded"

            PropertyChanges {
                target: load
                opacity: 1
            }

            PropertyChanges {
                target: save
                opacity: 1
            }

            PropertyChanges {
                target: camera
                opacity: 1
            }

            PropertyChanges {
                target: showMenuButton
                opacity: 0
            }
        }
    ]
}
