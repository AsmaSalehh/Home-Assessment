import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 400
    height: 400
    title: "Analog Clock"

    Rectangle {
        id: clock
        width: 200
        height: 200
        anchors.centerIn: parent
        border.color: "black"
        border.width: 2
        radius: width / 2

        // Draw clock numbers
        Repeater {
            model: 12
            delegate: Text {
                text: index === 0 ? "12" : index.toString()
                font.bold: true
                font.pointSize: 12
                color: "black"

                // Calculate position using trigonometry
                property real angle: -90 + index * 30
                property real textRadius: clock.width / 2 * 0.8 // Adjust text radius

                // Positioning the numbers according to clock orientation
                x: clock.width / 2 + textRadius * Math.cos(Math.PI / 180 * angle) - width / 2
                y: clock.height / 2 + textRadius * Math.sin(Math.PI / 180 * angle) - height / 2
            }
        }

        // Draw hour hand
        Rectangle {
            id: hourHand
            width: 4
            height: 80
            color: "black"
            rotation: -90 + (new Date().getHours() % 12) * 30 + new Date().getMinutes() / 2
            anchors.centerIn: parent

            // Draggable MouseArea for adjusting hours
            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis // Allow horizontal dragging only
                drag.minimumX: clock.width / -2 // Limit dragging within clock boundaries
                drag.maximumX: clock.width / 2 - parent.width // Limit dragging within clock boundaries

                onPositionChanged: {
                    // Calculate the new hour based on the drag position
                    var newHour = Math.floor((parent.x + parent.width / 2) / clock.width * 12);
                    if (newHour < 0) newHour += 12;
                    hourHand.rotation = -90 + newHour * 30 + new Date().getMinutes() / 2;
                }
            }
        }

        // Draw minute hand
        Rectangle {
            id: minuteHand
            width: 2
            height: 120
            color: "black"
            rotation: -90 + new Date().getMinutes() * 6 + new Date().getSeconds() / 10
            anchors.centerIn: parent

            // Draggable MouseArea for adjusting minutes
            MouseArea {
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis // Allow horizontal dragging only
                drag.minimumX: clock.width / -2 // Limit dragging within clock boundaries
                drag.maximumX: clock.width / 2 - parent.width // Limit dragging within clock boundaries

                onPositionChanged: {
                    // Calculate the new minute based on the drag position
                    var newMinute = Math.floor((parent.x + parent.width / 2) / clock.width * 60);
                    if (newMinute < 0) newMinute += 60;
                    minuteHand.rotation = -90 + newMinute * 6 + new Date().getSeconds() / 10;
                }
            }
        }

        // Draw seconds hand
        Rectangle {
            id: secondHand
            width: 1
            height: 140
            color: "red"
            rotation: -90 + new Date().getSeconds() * 6
            anchors.centerIn: parent
        }
    }

    // Timer to update clock hands in real-time
    Timer {
        interval: 1000 // Update every second
        running: true
        repeat: true
        onTriggered: {
            // Update the rotation of hour, minute, and second hands
            hourHand.rotation = -90 + (new Date().getHours() % 12) * 30 + new Date().getMinutes() / 2;
            minuteHand.rotation = -90 + new Date().getMinutes() * 6 + new Date().getSeconds() / 10;
            secondHand.rotation = -90 + new Date().getSeconds() * 6;
        }
    }
}
