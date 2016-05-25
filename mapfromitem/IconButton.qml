import QtQuick 2.4
import Ubuntu.Components 1.3

AbstractButton {
    id: button

    property string iconName
    property alias iconColor: icon.color

    width: units.gu(5)
    height: width

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(1.0, 1.0, 1.0, 0.3)
        visible: button.pressed
    }

    Icon {
        id: icon
        anchors.centerIn: parent
        width: units.gu(2.5)
        height: width
        color: "white"
        name: action ? action.iconName : button.iconName
        opacity: action ? (action.enabled ? 1.0 : 0.5) : 1.0
    }
}
