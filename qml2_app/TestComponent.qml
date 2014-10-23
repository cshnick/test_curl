import QtQuick 2.3

Item {
    width: 400
    height: 300

    Column {
        id: column1
        anchors.fill: parent

        Text {
            id: text1
            text: "Kyle cut"
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 12
        }

        Image {
            id: image1
            width: 100
            height: 100
            source: "../../../../Downloads/kyle_transparent1.png"
        }

        ListView {
            id: listView1
            y: 0
            height: 160
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    spacing: 10
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                    }

                    Text {
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
            }
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
        }
    }
}
