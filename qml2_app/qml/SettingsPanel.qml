import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root_item

    MouseArea {
        id: root_area

        anchors.fill: rect_test
    }

    Item {
        id: container;
        x: -(2 * rectShadow.radius)
        y: 0
        width:  rect_test.width  + (2 * rectShadow.radius);
        height: rect_test.height + (2 * rectShadow.radius);

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
            y:  (2 * rectShadow.radius);
            width: rect_test.width
            height: rect_test.height
            id: id_col
            spacing: 5

            Text {
                x: 20
                text: "Settings"
                font.pixelSize: window.global_height * 0.05
                font.bold: true
                color: "#444"
            }

            Rectangle {
                x: 2 * rectShadow.radius
                color: "#444"
                width: rect_test.width - 4 * rectShadow.radius;

                height: 2
                border.width: 2
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
