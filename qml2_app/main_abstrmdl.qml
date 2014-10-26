import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import CurrcData 1.0

Window {
    visible: true
    width: 300
    height: 360

    //    MouseArea {
    //        anchors.fill: parent
    //        onClicked: {
    //            Qt.quit();
    //        }
    //    }

    Item {
        id: column1
        anchors.fill: parent
        width: parent.width
        anchors.topMargin: 5

        //CurrencyData {id: data_set}

        CLineEdit {

            id: ti1
            height: 25
            color: "#2E6496"
            text: qsTr("Line edit text")
            anchors.left: parent.left
            anchors.leftMargin: 5
            //            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            font.pixelSize: 12
            onLe_textChanged: dataModel.stringChanged(text)
        }

        Item {
            anchors.topMargin: 5
            anchors.top: ti1.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            clip: true

            ListView {
                id: listView1
                //            anchors.topMargin: 5
                anchors.fill: parent
                delegate: Item {
                    id: delegate
                    x: 5
                    width: parent.width - 10
                    height: 40
                    Row {
                        id: row1
                        spacing: 10
                        width: parent.width

                        Rectangle {
                            width: 40
                            height: 40
                            color: colorCode
                            Text {
                                color: "white"
                                text: code
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }

                        Column {
                            spacing: 2
                            Text {
                                y: 2
                                text: name
                                font.bold: true
                            }
                            Text {
                                y: 2
                                text: value
                                font.bold: false
                            }
                        }
                    }
                }
                model: CurrencyFilterModel {
                    id: dataModel

                    Component.onCompleted: dataModel.refresh()
                }
            }
        }
    }
}
