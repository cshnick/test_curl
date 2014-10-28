import QtQuick 2.3
import CurrcData 1.0

Item {
    property CurrencyFilterModel dtaModel: dataModel

    id: listView_main

    ListView {
        id: listView1
        //            anchors.topMargin: 5
        anchors.fill: parent
        delegate: Item {
            id: delegate
            x: 5
            width: parent.width - 3
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
            MouseArea {
                id: mouse_area1
                z: 1
                hoverEnabled: false
                anchors.fill: parent
                onClicked:  {listView1.currentIndex = index }
            }
        }
        model: CurrencyFilterModel {
            id: dataModel

            Component.onCompleted: dataModel.refresh()
        }
        highlight: Rectangle  {
            color:"black"
            x: 3
            radius: 3
            opacity: 0.5
            focus: true
        }
    }
}
