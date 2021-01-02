import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
//import QtQuick.Controls 1.4 as Old
import hms.dto 1.0
import "qrc:/"

Window {
    property string _mode: "add"
    property int _recordId: -1
    property alias _selectedInventoryItems: inventoryListView._selectedItems
    id: root
    width: 600
    height: 600
    visible: true
    title: qsTr("Add/Modify Room")
    color: "floralwhite"



    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        ColumnLayout {
            id: columnLayout
            Layout.fillHeight: true
            Layout.fillWidth: true

            Label {
                id: label
                text: qsTr("Room Name:")
            }

            TextField {
                id: roomNameTextField
                Layout.fillHeight: false
                Layout.fillWidth: true
                placeholderText: qsTr("Ex: 101, A101")
            }

            Label {
                id: label3
                text: qsTr("Room type:")
            }

            ComboBox {
                id: roomTypeComboBox
                model: roomTypeModel
                textRole: "name"
                valueRole: "id"
                onActivated: function(index) {
                    console.log("seletect " + index)
                    console.log(currentValue)
                }
            }

            RowLayout {
                id: rowLayout1
                Layout.fillWidth: true

                CheckBox {
                    id: needCleanCheckBox
                    text: qsTr("Need clean")
                    Layout.fillWidth: true
                }

                CheckBox {
                    id: lockRoomCheckBox
                    text: qsTr("Hide room")
                    Layout.fillWidth: true
                }



            }

            Label {
                id: label2
                text: qsTr("Description:")
            }

            Flickable {
                id: flickable1
                Layout.minimumHeight: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                TextArea.flickable: TextArea {
                    selectByMouse: true
                    id: descriptionTextArea
                    wrapMode: TextEdit.Wrap
                    background: Rectangle {
                        color:  "white"
                        border.color: descriptionTextArea.focus ? "mediumblue" : "darkgrey"
                        border.width: descriptionTextArea.focus ? 2 : 1
                    }

                }
            }

            Label {
                id: label1
                text: qsTr("Room inventory items:")
            }

            ListView {
                id: inventoryListView
                property var _selectedItems: []
                width: 110
                height: 160
                Layout.fillWidth: true
                Layout.fillHeight: false
                clip: true
                ScrollBar.vertical: ScrollBar  {
                    policy: ScrollBar.AlwaysOn
                }

                delegate: Item {
                    x: 5
                    width: 80
                    height: 40
                    CheckBox {
                        id: checkBox3
                        text: inventoryListView.model.data(inventoryListView.model.index(index, 1), display)
                        Layout.fillWidth: true
                        Component.onCompleted: {
                            console.log(inventoryListView._selectedItems)
                            let currentItemId = inventoryListView.model.data(inventoryListView.model.index(index, 0), display)
                            if (inventoryListView._selectedItems.indexOf(currentItemId) >= 0) {
                                checkBox3.checked = true
                            }
                        }

                        onCheckedChanged: {

                            let currentItemId = inventoryListView.model.data(inventoryListView.model.index(index, 0), display)
                            let splice = inventoryListView._selectedItems.indexOf(currentItemId)
                            if (splice >= 0)
                                inventoryListView._selectedItems.splice(splice, 1)
                            if (checkBox3.checked) {
                                inventoryListView._selectedItems.push(currentItemId)
                            }
                        }
                    }
                }
                model: inventoryModel
            }







        }

        RowLayout {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Save and Create New")
            }

            Button {
                text: qsTr("Save")
                onClicked: {
                    if (_mode == "add") {
                        let ok = roomModel.addRoom(
                                roomNameTextField.text,
                                parseInt(roomTypeComboBox.currentValue),
                                needCleanCheckBox.checked,
                                lockRoomCheckBox.checked,
                                descriptionTextArea.text,
                                inventoryListView._selectedItems)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let ok = roomModel.updateRoom(
                                _recordId,
                                roomNameTextField.text,
                                parseInt(roomTypeComboBox.currentValue),
                                needCleanCheckBox.checked,
                                lockRoomCheckBox.checked,
                                descriptionTextArea.text,
                                inventoryListView._selectedItems)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                }
            }

            Button {
                text: qsTr("Cancel")
                onClicked: {
                    root.close()
                }
            }
        }






    }
    //Component.
    Component.onCompleted: {
        if (_recordId >= 0) {
            roomNameTextField.text = roomModel.get(_recordId).name
            roomTypeComboBox.currentIndex = roomTypeComboBox.indexOfValue(roomModel.get(_recordId).roomTypeId)
            needCleanCheckBox.checked = roomModel.get(_recordId).needClean
            lockRoomCheckBox.checked = roomModel.get(_recordId).locked
            descriptionTextArea.text = roomModel.get(_recordId).description
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
