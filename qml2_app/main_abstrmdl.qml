import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import CurrcData 1.0

Window {
    visible: true
    width: 300
    height: 360

    Item {
        id: column1
        anchors.fill: parent
        width: parent.width
        anchors.topMargin: 5
        state: "NORMAL"


        CLineEdit {
            id: ti1
            height: 25
            color: "#2E6496"
            text: qsTr("")
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            font.pixelSize: 12
            onLe_textChanged: listView.dtaModel.stringChanged(text)
            waitInput: false

        }

        CListView {
            id: listView

            anchors.topMargin: 5
            anchors.top: ti1.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            clip: true

            visible: false
        }
        states: [
            State {
                name: "SEARCH"
                when: ti1.waitInput == true
                PropertyChanges { target: listView; visible: true}
            },
            State {
                name: "NORMAL"
                PropertyChanges { target: listView; visible: false}
            }
        ]
    }
}
