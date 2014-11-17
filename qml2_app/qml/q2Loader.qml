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

    CMainList {}
}
