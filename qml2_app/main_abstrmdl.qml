import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import CurrcData 1.0

Window {
    visible: true
    width: 360
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

        //CurrencyData {id: data_set}

        TextInput {
            id: ti1
            horizontalAlignment: Text.AlignRight
            font.pointSize: 12
            anchors.top: parent.top
        }

        ScrollView {
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
                model: CurrencyDataModel {
                    id: dataModel

                    Component.onCompleted: dataModel.refresh()
                }
                TestComponent {
                    id: testComp
                    anchors.fill: parent
                }
            }
        }
    }
}
