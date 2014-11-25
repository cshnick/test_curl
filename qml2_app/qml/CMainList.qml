import QtQuick 2.0
import CurrcData 1.0

import "MainListHelper.js" as JSHelper

Item {
    id: root_whole
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
                    font.pixelSize: window.global_height * 0.05
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
                font.pixelSize: window.global_height * 0.0375
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

                iconwidth: window.global_height * 0.083
                iconheight: window.global_height * 0.083
                icontextsize: window.global_height * 0.025
                itemtextpixsize: window.global_height * 0.025

                function process_index(pl_index) {
                    JSHelper.writeToSettings(pl_index, lstView.model, settings, index)
                    root_item.state = ""

                    var root_model = root_item.ListView.view.model
                    var root_index = root_item.ListView.view.currentIndex
                    var replace_list_element = JSHelper.elemFromParams(lstView.currentIndex, lstView.model)
                    root_model.set(index, replace_list_element)

                    var c = new JSHelper.Model_context(root_model, index, valueEdit.text)
                    console.log("model: " + c.model + "; index: " + c.index + "; other index: " + c.other_index + "; text: " + valueEdit.text)
                    root_model.setProperty(c.other_index, "count", c.formatted_calc())
                }

                onClicked: {
                    process_index(l_index)
                }

                lstView.model: m_model

                lstView.currentIndex: m_index
                opacity: 0
            }

            CInputEdit {
                id: valueEdit

                anchors.bottom: root_item.bottom
                width: root_list.width
                height: window.global_height * 0.083 //If we change resolution
                color: "#2E6496"
                textColor: "#2E6496"
                text: count
                font.pixelSize: window.global_height * 0.083 / 2
                font.bold: true
                selectByMouse: true
                horisontalAlignment: Text.AlignRight
                //                    z: textFocus ? 2 : 0
                z: 2
                onTextChanged: {
                    if (textFocus) { //Disable recursive onTextChanged calls
                        var c = new JSHelper.Model_context(root_model, index, text)
                        root_model.setProperty(c.other_index, "count", c.formatted_calc())
                    }
                }
                onTextFocusChanged: {
                    //                        root_item.ListView.view.hasTextFocus = focus
                    //                        console.log("Text Focus changed to" + focus)
                    //                        console.log("global focus" + root_item.ListView.view.hasTextFocus)

                }
            }

            CInputEdit {
                id: search_input

                y: -height
                anchors.horizontalCenter: parent.horizontalCenter
                width: root_list.width
                height: global_height * 0.0625
                font.pixelSize: global_height * 0.0625 / 2
                textColor: "#2E6496"
                font.bold: false
                onInputTextChanged: m_model.stringChanged(text)

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
                onEditFinished: {
                    inputMethod.hide()
                }

                opacity: 0
                visible: false

            }

            MouseArea {
                id: ch_area

                enabled: root_item.state != "CHOOSE"
                anchors {top: parent.top; left: parent.left}
                width: parent.width
                height: parent.height - valueEdit.height
                z: 1
                onClicked: {
                    console.log("<<--ch_area clicked-->")
                    console.log("value edit focus: " + valueEdit.focus)
                    valueEdit.focus = true
                    root_item.state = "CHOOSE"
                    console.log("requesting code: " + root_model.get(index).code)
                    m_model.stringChanged("")
                    var index1 = m_model.indexFromCode(root_model.get(index).code)
                    cur_list.lstView.currentIndex = index1
                    cur_list.lstView.positionViewAtIndex(index1, ListView.Beginning)
                    if (!settings.Android) {
                        search_input.forceTextFocus()
                    }
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
                },
                State {
                    name: "ENTER_VALUE"

                    //                        PropertyChanges {target: root_list}
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

        property bool hasTextFocus: false
        x: parent.x; y: parent.y
        width: parent.width; height: parent.height
        model: root_model
        delegate: root_delegate
    }

    ListModel {
        id: root_model

        ListElement {
            name: ""
            code: ""
            value: 0
            count: 1
            color_val: ""
            m_index: 22
        }
        ListElement {
            name: ""
            code: ""
            value: 0
            color_val: ""
            m_index: 145
            count: 0
        }

        Component.onCompleted: {
            var elem1 = JSHelper.elemFromSettings(0, settings, m_model.parser)
            console.log("list model completed")
            set(0, JSHelper.elemFromSettings(0, settings, m_model.parser))
            set(1, JSHelper.elemFromSettings(1, settings, m_model.parser))
        }
    }

    states: [
        State {
            name: "state1"
            PropertyChanges {target: root_list; visible: false}
        }
    ]
}


