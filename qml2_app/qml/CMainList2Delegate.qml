import QtQuick 2.0

Item {
    id: list_delegate
    width: parent.width
    height: iconheight

    Row {
        id: row1
        spacing: 10
        width: parent.width

        Rectangle {
            width: iconwidth
            height: iconheight
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
