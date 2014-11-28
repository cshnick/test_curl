import QtQuick 2.0
import CurrcData 1.0
import QtQuick.Window 2.0

Window {
    id: window

    Settings {
        id: settings
    }

    property int global_width: settings.Android ? 720 : 270
    property int global_height: settings.Android ? 1240 : 480

    width: global_width
    height: global_height
    visible: true

    Connections {
       target: m_model
       onParserChanged: {
            console.log("parser changed call from window, parser is " + parser)
       }
    }

    Item {
        id: window_wrapper

        anchors.fill: parent

        CMainList {id: main_list}

        CurrencyFilterModel {
            id: m_model

            Component.onCompleted: parser = settings.value("main/engine", "nbrb")
//            Component.onCompleted: refresh()
            onParserChanged: {
                refresh()
            }
        }

        MouseArea {
            id: settingsArea
            anchors.top: parent.top
            anchors.left: parent.left

            height: parent.height
            width: global_width * 0.025
            z: 1

            onClicked: {
                console.log("settingsarea clicked")
                window_wrapper.state = "show_settings"
            }
        }

        MouseArea {
            anchors.fill: parent

            enabled: settings_panel.x === 0
            onClicked: {
                console.log("Disabling area clicked")
                window_wrapper.state = ""
            }
        }

        SettingsPanel {
            id: settings_panel

            width: global_width - global_width * 0.1
            height: parent.height

            x: -width
            y: 0

            Component.onCompleted: {
                console.log("settings panel width: " + width + "; global width: " + global_width)
            }
        }

        states: [
            State {
                name: "show_settings"
                PropertyChanges { target: settings_panel; x: 0; visible: true }
//                PropertyChanges { target: main_list; opacity: 0}
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {properties: "x"; duration: 150}
            }
        ]
    }
}
