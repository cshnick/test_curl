import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Button {
    id: engine_button

    property var color

    //Trig button when parser changed
    Connections {
        target: m_model
        onParserChanged: {
            if (parser === text) {
                checked = true
            }
        }
    }

    width: parent.width
    height: 30
//    activeFocusOnPress: true
    checkable: true

    style: Component {
        id: b_s

        ButtonStyle {
            id: button_style
            background: Rectangle {
                id: button_rect

                width: parent.width
                height: parent.height
                color: control.checked ? engine_button.color : "#ccc"
            }
            label: Label {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: control.text
                color: control.checked ? "white" : "black"
                font.bold: true
            }
        }
    }

    Component.onCompleted: {
        console.log("component button created")
    }

    onCheckedChanged: {
        if (checked) {
            settings.setValue("main/engine", text)
        }
    }

    onClicked: {
        console.log("Settings button clicked")
        m_model.parser = text
    }
}
