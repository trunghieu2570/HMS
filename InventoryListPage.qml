import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "qrc:/"

//Page: Inventory List
Rectangle {
    id: inventoryPage
    property variant _win
    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                text: qsTr("Add Item")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddInventoryItemDialog.qml")
                    _win = _com.createObject(inventoryPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Refresh")
                onClicked: {
                    inventoryModel.populate()
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }
            TextField {
                id: searchTextField
                height: 30
                selectByMouse: true
                placeholderText: qsTr("Find something...")
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("Find")
                onClicked: {
                    inventoryModel.populate(searchTextField.text)
                }
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("Reset")
                onClicked: {
                    searchTextField.text = qsTr("")
                    inventoryModel.populate(searchTextField.text)
                }
            }
        }
        HTableView {
            id: inventoryTable
            _model: inventoryModel
            columnWidthProvider: function(column) {
                let columns = [100,inventoryTable.width - 200]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                let _com = Qt.createComponent("qrc:/dialogs/AddInventoryItemDialog.qml")
                _win = _com.createObject(inventoryPage, {_recordId: index, _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    inventoryModel.deleteRow(index)
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Do you really want to delete this item?",
                    _title: "Confirm"
                }
                let _mbwin = _mb.createObject(inventoryPage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
