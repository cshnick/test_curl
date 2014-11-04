import QtQuick 2.3
import CurrcData 1.0

Item {
    property CurrencyFilterModel dtaModel: dataModel
    property alias lstView: listView1

    id: listView_main
    signal clicked(int l_index)

    ListView {
        id: listView1

        clip: true
        anchors.fill: parent
        highlightMoveDuration: 75
        delegate: Item {
            id: delegate
            width: parent.width
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
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Text {
                        text: name
                        font.bold: true
                    }
                    Text {
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
                onClicked:  {
                    listView1.currentIndex = index
                    listView_main.clicked(index)
                }
            }
        }
        model: CurrencyFilterModel {
            id: dataModel

            Component.onCompleted: dataModel.refresh()
        }
        highlight: Rectangle  {
            color:"black"
            radius: 3
            opacity: 0.5
            focus: true
        }
    }
}
