import QtQuick 2.4
import Ubuntu.Components 1.3

AbstractButton {
    id: optionValueButton

    implicitHeight: units.gu(5)

    property alias label: label.text
    property alias iconName: icon.name
    property bool selected
    property bool isLast
    property int columnWidth
    property int marginSize: units.gu(1)

    width: marginSize + iconLabelGroup.width + marginSize

    Item {
        id: iconLabelGroup
        width: childrenRect.width
        height: icon.height

        anchors {
            left: (iconName) ? undefined : parent.left
            leftMargin: (iconName) ? undefined : marginSize
            horizontalCenter: (iconName) ? parent.horizontalCenter : undefined
            verticalCenter: parent.verticalCenter
            topMargin: marginSize
            bottomMargin: marginSize
        }

        Icon {
            id: icon
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }
            width: optionValueButton.height - optionValueButton.marginSize * 2
            color: "white"
            opacity: optionValueButton.selected ? 1.0 : 0.5
            visible: name !== ""
        }

        Label {
            id: label
            anchors {
                left: icon.name != "" ? icon.right : parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: units.gu(0.5)
            }

            color: "white"
            opacity: optionValueButton.selected ? 1.0 : 0.5
            width: paintedWidth
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        width: parent.columnWidth
        height: units.dp(1)
        color: "red"
        opacity: 0.5
        visible: true
    }
}
