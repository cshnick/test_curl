import QtQuick 1.1
import CurrcData 1.0

Rectangle {
    width: 270
    height: 480
    visible: true
    //    Rectangle {
    //        anchors.fill: parent

    //        color: "blue"
    //        opacity: 0.3
    //    }
    ListView {
        anchors.fill: parent
        delegate: Item {
            height: 40
//            anchors.fill: parent
            Rectangle {
                id: image
                height: parent.height
                width: height

                color: "blue"
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.bold: true
                    text: index
                    color: "white"
                }
            }
            Text {
                x: image.width + 5
                y: 0
                width: parent.width - x
                height: image.height
                verticalAlignment: Text.AlignVCenter

                text: mdl.get(index, EnumProvider.ValueRole)
            }

        }
        model: CurrencyFilterModel {
            id: mdl

            Component.onCompleted: refresh()
        }
    }
}
