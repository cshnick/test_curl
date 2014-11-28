import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import CurrcData 1.0
import "SettingsPanel" as SP

Item {
    id: root_item

    Item {
        id: container;
        x: -(2 * rectShadow.radius)
        y: 0
        width:  rect_test.width  + (2 * rectShadow.radius);
        height: rect_test.height + (2 * rectShadow.radius);

        MouseArea {
            id: root_area

            anchors.fill: rect_test
        }

        Rectangle {
            id: rect_test
            width: root_item.width;
            height: root_item.height - 2 * rectShadow.radius;
            color: "white";
            antialiasing: true;
            anchors.centerIn: parent;
        }

        Item {
            id: root_calcItem
            x: (2 * rectShadow.radius);
            y:  rectShadow.radius
            width: rect_test.width - rectShadow.radius
            height: rect_test.height

            Rectangle {
                id: deco
                x: 0
                width: parent.width
                height: window.global_height * 0.083
                color: "#2E6496"

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    x: 20
                    text: "Settings"
                    font.pixelSize: window.global_height * 0.04
                    font.bold: true
                    color: "#EEE"
                }
            }

            Flickable {
                property int offset: window.global_height * 0.012
                id: engine_groupbox

                y: deco.height + offset
                width: parent.width
                height: root_calcItem.height - deco.height - offset

                Column {
                    id: button_container

                    spacing: engine_groupbox.offset
                    width: parent.width

                    Text {
                        x: engine_groupbox.offset
                        font.pixelSize: window.global_height * 0.028
                        font.underline: true
                        font.bold: true
                        text: "Engines"
                    }

                    ExclusiveGroup {
                        id: group_engines
                    }

                    function loadButton(text, color) {
                        var component = Qt.createComponent("qrc:/qml/SettingsPanel/SettingsButton.qml");
                        if (component.status === Component.Ready) {
                            var button = component.createObject(button_container);
                            button.text = text;
                            button.color = color
                            button.exclusiveGroup = group_engines
                            button.x = engine_groupbox.offset
                            button.width = button_container.width - 2 * engine_groupbox.offset
                            //                        m_model.parserChanged.connect(connectButton())
                        } else {
                            console.log("=== Error: " + component.errorString())
                        }
                    }

                    Component.onCompleted: {
                        loadButton(m_model.parserNames()[0], "#0465D0")
                        loadButton(m_model.parserNames()[1], "#19CE5E")
                    }
                }
            }
        }
    }
    DropShadow {
        id: rectShadow;
        anchors.fill: source
        cached: true;
        horizontalOffset: 3;
        verticalOffset: 0;
        radius: 8.0;
        samples: 16;
        color: "#80000000";
        smooth: true;
        source: container;
    }

    ListModel {
        id: engine_model

        Component.onCompleted: {
            var colorList = ["#0465D0", "#19CE5E"]
            console.log("entering list")
            var lst = m_model.parserNames()
            for (var i = 0; i < lst.length; i++ ) {
                console.log("next iter")
                append({"name":lst[i],
                           "color_val": colorList[i]});
            }
        }
    }


}
