import QtQuick 2.0
import CurrcData 1.0
import QtQuick.Window 2.0
import "MainListHelper.js" as JSHelper

Window {
    width: 280
    height: 480
    visible: true
    Item {
        x: parent.x
        y: parent.y
        width: parent.width
        height: parent.height
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
                            result = Math.min(parent.height - valueEdit.height, parent.width / 2)
                        } else {
                            result = Math.min(parent.width/2, parent.height - valueEdit.height)
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

                    x: 0; y: root_list.height
                    width: parent.width
                    height: parent.height

                    function process_index(pl_index) {
                        Settings.setValue("main/index" + index, pl_index)
                        root_item.state = ""

                        var root_model = root_item.ListView.view.model
                        var root_index = root_item.ListView.view.currentIndex
                        var replace_list_element = elemFromParams(lstView.currentIndex, lstView.model)
                        root_model.set(index, replace_list_element)
                    }

                    function elemFromParams(index, model) {
                        console.log("elemFromParams-> : ", model.get(index, EnumProvider.ColorNameRole))
                        return ({"name":model.get(index, EnumProvider.NameRole),
                                    "code":model.get(index, EnumProvider.CodeRole),
                                    "color_val":model.get(index, EnumProvider.ColorNameRole),
                                    "value":model.get(index, EnumProvider.ValueRole)
                                })
                    }

                    onClicked: {
                        process_index(l_index)
                    }


                    lstView.currentIndex: m_index
                    opacity: 0
                }

                CInputEdit {
                    id: valueEdit


                    function to_formatted(arg) {
                        var result = NaN
                        if (arg !== NaN) {
                            result = arg.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& ')
                        }

                        return result
                    }

                    function from_formatted(arg) {
                        arg = arg.toString()
                        return parseFloat(arg.replace(/\s/g,''))
                    }

                    function calculate(val1, val2) {
                        console.log("calculate result:")
                        console.log("val1: " + val1 + "; val2: " + val2 + "; text" + text)
                        var result = val2 * from_formatted(text) / val1
                        return result
                    }

                    anchors.bottom: root_item.bottom
                    width: root_list.width
                    height: 40
                    color: "#2E6496"
                    textColor: "#2E6496"
                    text: count
                    font.pixelSize: 20
                    font.bold: true
                    selectByMouse: true
                    horisontalAlignment: Text.AlignRight
                    onTextChanged: {
                        /// Detect index for opposite item
                        var otherIndex = index ? 0 : 1
                        var num = parseFloat(text.replace(/\s/g,''))

                        if (textFocus) { //Disable recursive onTextChanged calls
                            var val1 = root_model.get(index).value
                            var val2 = root_model.get(otherIndex).value
                            var result = to_formatted(calculate(val1, val2))
                            root_model.setProperty(otherIndex, "count", result)
                            console.log("Original num: " + num + "; Formatted number: " + num.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$& '))
                        }
                    }
                }

                CInputEdit {
                    id: search_input

                    y: -height
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: root_list.width
                    height: 30
                    font.pixelSize: 16
                    textColor: "#2E6496"
                    font.bold: false
                    onInputTextChanged: cur_list.dtaModel.stringChanged(text)

                    Keys.onUpPressed: {
                        cur_list.lstView.decrementCurrentIndex()
                    }
                    Keys.onDownPressed: {
                        cur_list.lstView.incrementCurrentIndex()
                    }
                    Keys.onReturnPressed: {
                        console.log("return pressed")
                        cur_list.process_index(cur_list.lstView.currentIndex)
                    }

                    opacity: 0
                    visible: false
                    z: 1
                }

                MouseArea {
                    id: ch_area

                    enabled: root_item.state != "CHOOSE"
                    anchors {top: parent.top; left: parent.left}
                    width: parent.width
                    height: parent.height - valueEdit.height
                    z: 1
                    onClicked: {
                        valueEdit.focus = true
                        root_item.state = "CHOOSE"
                        var index1 = Settings.value("main/index1", 22)
                        cur_list.lstView.currentIndex = index1
                        cur_list.lstView.positionViewAtIndex(index1, ListView.Beginning)
                        search_input.forceTextFocus()
                    }
                }

                function check_y() {
                    return index ? -root_list.height / 2 : 0
                }

                states: [
                    State {

                        name: "CHOOSE"
                        AnchorChanges {target: image; anchors.right: parent.left}
                        AnchorChanges {target: name_text; anchors.left: parent.right}
                        PropertyChanges {target: valueEdit; opacity: 0}
                        PropertyChanges {target: search_input; opacity: 1; visible: true; y: 0}
                        PropertyChanges {target: cur_list; opacity: 1; y: search_input.height}
                        PropertyChanges {target: root_item; height: root_list.height; y: root_list.y}
                        PropertyChanges {target: root_list; y: check_y(); interactive: false}
                    }
                ]
                transitions: [
                    Transition {
                        ParallelAnimation {
                            NumberAnimation {properties: "visible, opacity,y,x, contentX, contentY, height"; duration: root_item.animation_duration }
                            PropertyAction {target: cur_list; property: "opacity"; value: 1}
                            AnchorAnimation {duration: root_item.animation_duration}
//                            SpringAnimation {target: cur_list; properties: "y"; duration: root_item.animation_duration; spring: 5; damping: 0.3}
                        }
                    }
                ]
            }

        }

        ListView {
            id: root_list

            x: parent.x; y: parent.y
            width: parent.width; height: parent.height
            model: root_model
            delegate: root_delegate
        }


        ListModel {
            id: root_model

            ListElement {
                name: "Belarus Ruble"
                code: "BYR"
                value: 13622.697606962
                count: "1"
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

        states: [
        ]
    }
}


