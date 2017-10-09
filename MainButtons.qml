import QtQuick 2.6
import QtQuick.Controls 2.2

Item {
    id: root
    width: 190; height: 770
    state: "expanded"

    Button {
        id: showMenuButton
        x: -57
        y: -10
        width: 86;  height: 86

        opacity: 0
        background:
            Rectangle {
             id: recInButtonStyle
                color: showMenuButton.hovered ? Qt.lighter("#558C89", 1.2) : "transparent"
                border.width: showMenuButton.hovered ? 4 : 0
                border.color: Qt.lighter("#74AFAD", 1.3)
                radius: 5
            }

            Image {
               width: 83; height: 83
               anchors.fill: recInButtonStyle
               source: "qrc:///images/menu.png"
            }

        Behavior on opacity {
            NumberAnimation {
                duration: 1060
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
        height: 685
        anchors.verticalCenter: parent.verticalCenter
        spacing: 41

        MainButton {
            id: demo
            checkable: true
            sourceImage: "qrc:///images/stop.png"
            onClicked: {
                if(demo.checked) {
                    pathViewButtons.interactive = false
                    loaderOnCanvas.source = "DemoGlowLines.qml"
                    container.freezeOtherMenuButtons(demo)
                } else {
                    pathViewButtons.interactive = true
                    loaderOnCanvas.deactivateLoader();
                    container.activeMenuButtons()
                }
            }
        }

        MainButton {
            id: load
            sourceImage: "qrc:///images/load.png"
            onClicked: {
                imageDialog.open()
            }
        }

        MainButton {
            id: save
            sourceImage: "qrc:///images/save.png"
            onClicked:
                effects.switchActiveEffect("GENIE")
        }

        MainButton {
            id: camera
            checkable: true
            sourceImage: "qrc:///images/video.png"
            onClicked: {
                if(camera.checked) {
                    loaderOnCanvas.source = "FancyCamera.qml"
                    canvas.visible = false
                    pathViewButtons.interactive = false
                    container.freezeOtherMenuButtons(camera)
                } else {
                    pathViewButtons.interactive = true
                    loaderOnCanvas.deactivateLoader();
                    container.activeMenuButtons()
                }
            }
        }

        function disableChecked() {
            for(var i = 0; i< children.length; ++i) {
                if(children[i].checked)
                    children[i].checked = false
            }
        }

        function freezeOtherMenuButtons(button) {
            for(var i = 0; i< children.length; ++i) {
                children[i].enabled = false
            }
            button.enabled = true
        }

        function activeMenuButtons() {
            for(var i = 0; i< children.length; ++i) {
                children[i].enabled = true
            }
        }
    }

    states: [
        State {
            name: "slim"
            PropertyChanges {
                target: demo
                opacity: 0
            }

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
                target: demo
                opacity: 1
            }

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

    function activeButtons() {
        container.activeMenuButtons()
    }

    function disableChecked() { container.disableChecked(); }
}
