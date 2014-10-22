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

    ScrollView {
        id: column1
        anchors.fill: parent
        width: parent.width

        //CurrencyData {id: data_set}

        ListView {

            id: listView1
            anchors.topMargin: 5
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
                            text: currency_code
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
                            //                            anchors.right: parent.right
                        }
                    }
                }
            }
            //            highlight: Rectangle { x: 5; color: "lightsteelblue"; radius: 2 }

            model: ListModel {
                id: l_model

                function fillModel() {
                    d_set.refresh()

                    for (var i = 0; i < d_set.dataSet.length; i++) {
                        var si = d_set.dataSet[i]
                        console.log(si.name)
                        console.log("Color " + si.color_val.name + "Alt color: " + si.alt_color)
                        append({name:          si.name,
                                colorCode:     si.alt_color,
                                currency_code: si.code,
                                value:         si.value
                               })
                    }
                }

                Component.onCompleted: fillModel();
            }

            CurrencyDataSet {id: d_set}
        }
    }
}
