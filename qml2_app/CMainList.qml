import QtQuick 2.0
import CurrcData 1.0
import QtQuick.Window 2.0

Window {
    width: 280
    height: 480
    visible: true

    ListView {
        id: list_view
        Component {
            id: root_delegate
            Item {
                id: root_item
                width: parent.width
                height: list_view.height / 2
                Rectangle {
                    function checkWidth() {
                        var result
                        if (parent.width >= parent.height) {
                            result = Math.min(parent.height - inputEdit.height, parent.width / 2)
                        } else {
                            result = Math.min(parent.width/2, parent.height - inputEdit.height)
                        }
                        return result
                    }

                    id: image
                    width: checkWidth()
                    height: width
                    anchors.top: parent.top
                    color: color_val
                    Text {
                        anchors.centerIn: parent
                        text: code
                        font.pixelSize: 24
                        font.bold: true
                        color: "white"
                    }
                }
                Text {
                    id: name_text

                    anchors.left: image.right
                    anchors.top: parent.top
                    width: parent.width - image.width
                    height: image.height
                    color: "#444"
                    font.pixelSize: 18
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap

                    text: name
                }

                CListView {
                    anchors.top: image.bottom
                    width: parent.width
                    height: parent.height - image.height - inputEdit.height

                    opacity: 0
                }

                CInputEdit {
                    id: inputEdit
//                    anchors.margins: 3
                    anchors.bottom: root_item.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: list_view.width
                    height: 40
                    color: "#2E6496"
                    textColor: "#2E6496"
                    text: value
                    font.pixelSize: 20
                    font.bold: true
                    selectByMouse: true
                    horisontalAlignment: Text.AlignRight
                }

                Component.onCompleted: {
                    console.log("delegate completed\ncolor " + color_val)
                    console.log("list view height " + root_delegate.ListView.height)
                }
            }
        }
        anchors.fill: parent
        model: root_model
        delegate: root_delegate
    }

    ListModel {
        id: root_model

        ListElement {
            name: "Belarus Ruble"
            code: "BYR"
            value: 13622.697606962
            color_val: "#63BBEA"
        }
        ListElement {
            name: "US Dollar"
            code: "USD"
            value: 1.2737
            color_val: "#F075B7"
        }
    }

    states: [
        State {
            name: "CHOOSE"
            PropertyChanges {   }
        }
    ]
}


