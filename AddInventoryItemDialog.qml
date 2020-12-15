import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0

Window {
    property string _mode: "add"
    property int _recordId: -1
    id: root
    width: 400
    height: 130
    visible: true
    title: qsTr("Add/Modify Inventory Item")
    color: "floralwhite"

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        RowLayout {
            id: rowLayout1
            width: parent.width

            Label {
                id: label
                text: qsTr("Name: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                id: nameTextField
                maximumLength: 100
                //placeholderText: qsTr("Text Field")
            }
        }

        RowLayout {
            width: parent.width
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Save")
                onClicked: {
                    if (_mode == "add") {
                        let ok = inventoryModel.addRow(
                                    nameTextField.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let ok = inventoryModel.updateRow(
                                    _recordId,
                                    nameTextField.text)
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
    Component.onCompleted: {
        if (_recordId >= 0) {
            nameTextField.text = inventoryModel.get(_recordId).name
        }
    }
}
