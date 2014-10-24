import QtQuick 2.0

Rectangle {
    property alias font: input.font
    property string text: ""
    property alias selectByMouse: input.selectByMouse
    signal textChanged_le(string text)

    id: lineEdit
    height: input.height + 6
    color: "transparent"

    TextInput {
        id: input
        anchors.left: parent.left
        anchors.leftMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        color: "white"
        verticalAlignment: Text.AlignVCenter
        text: lineEdit.text
    }

    MouseArea {
        anchors.fill: parent
        onClicked: input.focus = true
    }

    states: [
        State {
            when: input.cursorVisible
            PropertyChanges { target: lineEdit; color: "white" }
            PropertyChanges { target: input; color: "black" }
        },
        State {
            when: text == ""
            PropertyChanges { target: lineEdit; border.color: "grey" }
        }
    ]

    Keys.onReturnPressed: {
        lineEdit.textChanged_le(input.text)
        lineEdit.focus = true
    }
    Keys.onEnterPressed: {
        lineEdit.textChanged_le(input.text)
        lineEdit.focus = true
    }
    Keys.onEscapePressed: {
        input.text = text
        lineEdit.focus = true
    }
}
