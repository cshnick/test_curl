import QtQuick 2.0
import CurrcData 1.0
import QtQuick.Window 2.0
import "MainListHelper.js" as JSHelper

Window {
    id: window

    property int global_width: Settings.Android ? 720 : 270
    property int global_height: Settings.Android ? 1240 : 480
    property CurrencyFilterModel g_model: Qt.createQmlObject('import QtQuick 2.0; import CurrcData 1.0; CurrencyFilterModel {
                        id: d_model

                        Component.onCompleted: refresh()
                    }', window, "")


    width: global_width
    height: global_height
    visible: true

    CMainList {}
}
