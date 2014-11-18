import QtQuick 1.1
import CurrcData 1.0

Item {
    id: list_delegate
    width: parent.width
    height: iconheight

    property CurrencyFilterModel mdl: ListView.view.model

    Row {
        id: row1
        spacing: 10
        width: parent.width

        Rectangle {
            width: iconwidth
            height: iconheight
            color: mdl.get(index, EnumProvider.ColorNameRole)
            Text {
                color: "white"
                text: mdl.get(index, EnumProvider.CodeRole)
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: icontextsize
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            Text {
                text: mdl.get(index, EnumProvider.NameRole)
                font.bold: true
                font.pixelSize: itemtextpixsize
            }
            Text {
                text: mdl.get(index, EnumProvider.ValueRole)
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
