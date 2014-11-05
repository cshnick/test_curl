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
            height: root_list.height / 2
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
                z: 1
                opacity: 0
            }

            CInputEdit {
                id: inputEdit

                anchors.bottom: root_item.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: root_list.width
                height: 40
                color: "#2E6496"
                textColor: "#2E6496"
                text: value
                font.pixelSize: 20
                font.bold: true
                selectByMouse: true
                horisontalAlignment: Text.AlignRight
            }

            CInputEdit {
                id: search_input

                y: -height
                anchors.horizontalCenter: parent.horizontalCenter
                width: root_list.width
                height: 30
                font.pixelSize: 16
                font.bold: true
                onInputTextChanged: cur_list.dtaModel.stringChanged(text)

                opacity: 0.1
                z: 1
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
                    search_input.forceTextFocus()
                }
            }

            states: [
                State {
                    name: "CHOOSE"
                    AnchorChanges {target: image; anchors.right: parent.left}
                    AnchorChanges {target: name_text; anchors.left: parent.right}
                    PropertyChanges {target: search_input; opacity: 1}
                    PropertyChanges {target: search_input; y: root_item.y}
                    PropertyChanges {target: search_input; textFocus: true}
                    PropertyChanges {target: cur_list; opacity: 1; y: search_input.height}
                    PropertyChanges {target: root_list; interactive: false}
                    PropertyChanges {target: root_item; explicit: true; height: root_list.height}
                }
            ]
            transitions: [
                Transition {
                    ParallelAnimation {
                        NumberAnimation {properties: "opacity"; duration: root_item.animation_duration}
                        NumberAnimation { targets: [search_input]; properties: "opacity,y"; duration: root_item.animation_duration }
                        PropertyAction {target: inputEdit; property: "opacity"; value: 0}
//                        PropertyAction {target: root_item; property: "height"; value: root_list.height}
                        PropertyAction {target: cur_list; property: "opacity"; value: 1}
                        AnchorAnimation {duration: root_item.animation_duration}
                        SpringAnimation {target: cur_list; properties: "y"; duration: root_item.animation_duration; spring: 5; damping: 0.3}
                    }
                }
            ]
        }
    }

    ListView {
        id: root_list

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


