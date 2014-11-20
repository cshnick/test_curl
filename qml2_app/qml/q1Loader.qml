import CurrcData 1.0
import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents

Rectangle {
    id: window

    property int minimumWidth: 300 // must set this in order for Plasma to "get" that this is really a PopupApplet
    property int minimumHeight: 350 // idem
    property int preferredWidth: 300
    property int preferredHeight: 350

    Settings {
        id: settings
    }

    clip: true

    property int global_width: settings.Android ? 720 : 270
    property int global_height: settings.Android ? 1240 : 480
        property Component compactRepresentation: Component {

        id: pact
        Rectangle {
            property int minimumWidth: 80
            property int minimumHeight: 30
            clip: true

            color: "transparent"

            Text {
                anchors.centerIn: parent
                id: abbr
                text: "csh\ncurrency"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
            }
            border.color: white
        }
    }

    width: global_width
    height: global_height
    visible: true

    CMainList {}

//    Component.onCompleted: {
//        plasmoid.popupIcon = QIcon("start-here-kde")
//    }
}
