import QtQuick 2.3
import CurrcData 1.0

Item {
    property alias lstView: listView1
    property size iconsize: Qt.size(40, 40)
    property int itemtextpixsize: 12
    property int icontextsize: 12

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
            height: iconsize.height

            Row {
                id: row1
                spacing: 10
                width: parent.width

                Rectangle {
                    width: iconsize.width
                    height: iconsize.height
                    color: colorCode
                    Text {
                        color: "white"
                        text: code
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: icontextsize
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Text {
                        text: name
                        font.bold: true
                        font.pixelSize: itemtextpixsize
                    }
                    Text {
                        text: value
                        font.bold: false
                        font.pixelSize: itemtextpixsize
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
        highlight: Rectangle  {
            color:"black"
            radius: 3
            opacity: 0.5
            focus: true
        }
    }
}
