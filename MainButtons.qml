import QtQuick 2.3

Item {
    id: root
    width: 210; height: parent.height
    state: "expanded"

    Rectangle {
        id: showMenuButton
        width: 60;  height: 60
        anchors {
            top: parent.top
            topMargin: 5
            right: parent.left
            rightMargin: 5
        }
        radius: 10

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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 200
        spacing: 80

        MainButton {
            id: load
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
                target: showMenuButton
                opacity: 0
            }
        }
    ]
}
