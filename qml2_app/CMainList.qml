import QtQuick 2.0
import CurrcData 1.0
import QtQuick.Window 2.0

Window {
    width: 280
    height: 480
    visible: true

    Component {
        id: root_delegate
        Item {
            id: root_item
            width: parent.width
            height: list_view.height / 2
            z: 0
            property int animation_duration: 150

            Rectangle {
                id: image

                function checkWidth() {
                    var result
                    if (parent.width >= parent.height) {
                        result = Math.min(parent.height - inputEdit.height, parent.width / 2)
                    } else {
                        result = Math.min(parent.width/2, parent.height - inputEdit.height)
                    }
                    return result
                }

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
                id: cur_list

                x: 0; y: parent.height
                width: parent.width
                height: parent.height - inputEdit.height

                function elemFromParams(model, index) {
                    console.log("elemFromParams-> : ", model.get(index, CurrencyDataModel.ColorNameRole))
                    return ({"name":model.get(index, CurrencyDataModel.NameRole),
                                "code":model.get(index, CurrencyDataModel.CodeRole),
                                "color_val":model.get(index, CurrencyDataModel.ColorNameRole)
                            })
                }

                onClicked: {
                    Settings.setValue("main/index1", l_index)
                    root_item.state = ""

                    var root_model = root_item.ListView.view.model
                    var root_index = root_item.ListView.view.currentIndex
                    var replace_list_element = elemFromParams(lstView.model, lstView.currentIndex)
                    root_model.set(root_index, replace_list_element)
                }


                lstView.currentIndex: m_index
                opacity: 0

            }

            CInputEdit {
                id: inputEdit

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
                onInputTextChanged: if (cur_list.opacity > 0) {
                                        cur_list.dtaModel.stringChanged(text)
                                    }
            }

            MouseArea {
                id: ch_area

                enabled: root_item.state != "CHOOSE"
                anchors {top: parent.top; left: parent.left}
                width: parent.width
                height: parent.height - inputEdit.height
                z: 1
                onClicked: {
                    inputEdit.focus = true
                    root_item.state = "CHOOSE"
                    var index1 = Settings.value("main/index1", 22)
                    cur_list.lstView.currentIndex = index1
                    cur_list.lstView.positionViewAtIndex(index1, ListView.Beginning)
                }
            }

            states: [
                State {
                    name: "CHOOSE"
                    AnchorChanges {target: inputEdit; anchors.top: parent.top; anchors.bottom: undefined}
                    //                        PropertyChanges {target: inputEdit; y: 0}
                    //                        PropertyChanges {target: inputEdit;  x: 0; y: 5}
                    PropertyChanges {target: name_text; opacity: 0}
                    PropertyChanges {target: image; opacity: 0}
                    PropertyChanges {target: cur_list; opacity: 1; y: inputEdit.height}
//                    PropertyChanges {target: root_item; height: list_view.height }
                    PropertyChanges {target: list_view; interactive: false}
                }
            ]
            transitions: [
                Transition {
                    ParallelAnimation {
                        NumberAnimation {properties: "opacity"; duration: root_item.animation_duration}
                        PropertyAction {target: root_item; property: "height"; value: list_view.height}
                        PropertyAction {target: cur_list; property: "opacity"; value: 0.5}
                        AnchorAnimation {duration: root_item.animation_duration}
                        NumberAnimation {target: cur_list; properties: "y"; duration: root_item.animation_duration}
                        //                            NumberAnimation {target: root_item; property: height; duration: 1500}
                    }
                }
            ]
        }
    }

    ListView {
        id: list_view

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
            m_index: 22
        }
        ListElement {
            name: "US Dollar"
            code: "USD"
            value: 1.2737
            color_val: "#F075B7"
            m_index: 145
        }
    }
}


