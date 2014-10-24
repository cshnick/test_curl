import QtQuick 2.3
import QtQuick.Window 2.0

Window {
    id: window1
    visible: true
    width: 400
    height: 300

    Flickable {
        id: column1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.left: parent.left



        CLineEdit {
            id: textInput1
            height: 20
            color: "#3e2727"
            text: qsTr("")
            anchors.left: parent.left
            anchors.leftMargin: 3
//            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.bottomMargin: 3
            anchors.topMargin: 3
            font.pixelSize: 12
            selectByMouse: true
        }

//        ListView {
//            id: listView1
//            y: 0
//            height: 160CLineEdit.qml
//            anchors.right: parent.right
//            anchors.bottom: parent.bottom
//            anchors.left: parent.left
//            delegate: Item {
//                x: 5
//                width: 80
//                height: 40
//                Row {
//                    id: row1
//                    spacing: 10
//                    Rectangle {
//                        width: 40
//                        height: 40
//                        color: colorCode
//                    }

//                    Text {
//                        text: name
//                        anchors.verticalCenter: parent.verticalCenter
//                        font.bold: true
//                    }
//                }
//            }
//            model: ListModel {
//                ListElement {
//                    name: "Grey"
//                    colorCode: "grey"
//                }

//                ListElement {
//                    name: "Red"
//                    colorCode: "red"
//                }

//                ListElement {
//                    name: "Blue"
//                    colorCode: "blue"
//                }

//                ListElement {
//                    name: "Green"
//                    colorCode: "green"
//                }
//            }
//        }
//        Text {
//            id: text1
//            text: "Kyle cut"
//            anchors.left: parent.left
//            anchors.leftMargin: 0
//            anchors.right: parent.right
//            anchors.rightMargin: 358
//            horizontalAlignment: Text.AlignLeft
//            font.pixelSize: 12
//        }
//        Image {
//            id: image1
//            width: 100
//            height: 100
//            source: "../../../../../Pictures/gdigraphics.png"
//            //source: "../../../../Downloads/kyle_transparent1.png"
//        }
    }
}
