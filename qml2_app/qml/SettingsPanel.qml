import QtQuick 2.0
import QtGraphicalEffects 1.0

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

        Column {
            x: (2 * rectShadow.radius);
            y:  rectShadow.radius
            width: rect_test.width - rectShadow.radius
            height: rect_test.height
            id: id_col
            spacing: 0

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

}
