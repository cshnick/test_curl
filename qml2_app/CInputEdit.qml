import QtQuick 2.0

Rectangle {
    id: input_edit

    signal clicked()
    signal editFinished(string str)
    signal editCanceled(string str)

    property alias text: input.text
    property alias font: input.font
    property alias selectByMouse: input.selectByMouse
    property alias verticalAlignment: input.verticalAlignment
    property alias horisontalAlignment: input.horizontalAlignment
    property color textColor

    width: 100
    height: 62
    TextInput {
        id: input
        anchors.fill: parent
        anchors.margins: 7
        verticalAlignment: TextInput.AlignVCenter

        color: "white"
    }

    MouseArea {
        id: tiMouseArea
        anchors.fill:parent

        onClicked: {
            input_edit.clicked()

            if (!input.activeFocus) {
                enabled = false
                input.forceActiveFocus()
//                input.cursorVisible = true
            }
        }
    }

    states: [
        State {
            when: input.cursorVisible
            PropertyChanges { target: input_edit; color: "white" }
            PropertyChanges { target: input; color: textColor }
        }
    ]

    Keys.onReturnPressed: {
        input_edit.editFinished(input.text)
        input_edit.focus = true
        tiMouseArea.enabled = true
    }
    Keys.onEnterPressed: {
        input_edit.editFinished(input.text)
        input_edit.focus = true
        tiMouseArea.enabled = true
    }
    Keys.onEscapePressed: {
        input.text = text
        input_edit.focus = true
        tiMouseArea.enabled = true
    }

    border.color: "grey"
    color: "#2E6496"
    Component.onCompleted: {
        tiMouseArea.clicked.connect(clicked)
    }
}
