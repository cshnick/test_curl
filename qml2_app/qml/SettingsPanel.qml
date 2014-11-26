import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import CurrcData 1.0

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
            x: (2 * rectShadow.radius);
            y:  rectShadow.radius
            width: rect_test.width - rectShadow.radius
            height: rect_test.height
            id: id_col

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
            ListView {

                y: deco.height + window.global_height * 0.025 //offset
                width: parent.width
                height: container.height / 1.5
                delegate: Component {
                    id: engine_delegate

                    Item {
                        width: parent.width
                        height: window.global_height * 0.083
                        id: root_engine_item
                        Rectangle {
                            height: 40
                            anchors.fill: parent
                            color: color_val
                            ToolButton {
                                anchors.centerIn: parent
                                width: parent.width / 1.5
                                height: parent.height / 2
                                text: name
                            }

                        }
                        Component.onCompleted: {
                            console.log("Delegate completed")
                        }
                    }

                }
                model: engine_model
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
            console.log("entering list")
            var lst = m_model.parserNames()
            for (var i = 0; i < lst.length; i++ ) {
                console.log("next iter")
                append({"name":lst[i],
                           "color_val": "#ccc"});
            }
        }
    }


}
