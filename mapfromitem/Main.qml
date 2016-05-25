import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "mapfromitem.liu-xiao-guo"

    width: units.gu(60)
    height: units.gu(85)
    theme.name :"Ubuntu.Components.Themes.SuruDark"
    property bool optionValueSelectorVisible: false

    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("mapfromitem")
        }

        ListModel {
            id: model
            property int selectedIndex: 0

            ListElement {
                icon: "account"
                label: "On"
                value: "flash-on"
            }
            ListElement {
                icon: "active-call"
                label: "Auto"
                value: "Auto"
            }
            ListElement {
                icon: "call-end"
                label: "Off"
                value: "flash-off"
            }
        }

        Column {
            id: optionValueSelector
            objectName: "optionValueSelector"
            width: childrenRect.width
            spacing: units.gu(1)

            property Item caller

            function toggle(model, callerButton) {
                if (optionValueSelectorVisible && optionsRepeater.model === model) {
                    hide();
                } else {
                    show(model, callerButton);
                }
            }

            function show(model, callerButton) {
                optionValueSelector.caller = callerButton;
                optionsRepeater.model = model;
                alignWith(callerButton);
                optionValueSelectorVisible = true;
            }

            function hide() {
                optionValueSelectorVisible = false;
                optionValueSelector.caller = null;
            }

            function alignWith(item) {
                // horizontally center optionValueSelector with the center of item
                // if there is enough space to do so, that is as long as optionValueSelector
                // does not get cropped by the edge of the screen
                var itemX = parent.mapFromItem(item, 0, 0).x;
                var centeredX = itemX + item.width / 2.0 - width / 2.0;
                var margin = units.gu(1);

                if (centeredX < margin) {
                    x = itemX;
                } else if (centeredX + width > item.parent.width - margin) {
                    x = itemX + item.width - width;
                } else {
                    x = centeredX;
                }

                // vertically position the options above the caller button
                y = Qt.binding(function() { return item.y - height - units.gu(2) });

                console.log("x: " + x + " y: " + y)
            }

            visible: opacity !== 0.0
            onVisibleChanged: if (!visible) optionsRepeater.model = null;
            opacity: optionValueSelectorVisible ? 1.0 : 0.0
            Behavior on opacity {UbuntuNumberAnimation {duration: UbuntuAnimation.FastDuration}}

            Repeater {
                id: optionsRepeater

                delegate: OptionValueButton {
                    anchors.left: optionValueSelector.left
                    columnWidth: optionValueSelector.childrenRect.width
                    label: model.label
                    iconName: model.icon
                    selected: optionsRepeater.model.selectedIndex == index
                    isLast: index === optionsRepeater.count - 1
                    onClicked: {
                        optionsRepeater.model.selectedIndex = index
                        console.log(optionsRepeater.model.get(index).value)
                    }
                }
            }
        }

        Icon {
            id: optionButton
            width: units.gu(3)
            height: width
            anchors.centerIn: parent
            name: model.get(model.selectedIndex).icon

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("optionValueSelectorVisible: " + optionValueSelectorVisible)
                    optionValueSelector.toggle(model, optionButton)
                }
            }
        }

        Component.onCompleted: {
            console.log("width: " + width + " height: " +height)
        }
    }

}

