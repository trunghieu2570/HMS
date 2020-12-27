import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "qrc:/"
import "qrc:/dialogs"

//Page: Client List
Rectangle {
    id: roomPage
    property variant _win
    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                text: qsTr("Add Item")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddRoomDialog.qml")
                    _win = _com.createObject(roomPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Refresh")
                onClicked: {
                    roomModel.populate()
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
                    roomModel.populate(searchTextField.text)
                }
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("Reset")
                onClicked: {
                    searchTextField.text = qsTr("")
                    roomModel.populate(searchTextField.text)
                }
            }
        }
        HTableView {
            id: roomTable
            _model: roomModel
            columnWidthProvider: function(column) {
                let columns = [0,100,0,200,0,0,roomTable.width - 400]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                let _com = Qt.createComponent("qrc:/dialogs/AddRoomDialog.qml")
                roomInventoryModel.populate(roomModel.get(index).id)
                _win = _com.createObject(roomPage, {_recordId: index, _mode: "edit", _selectedInventoryItems: roomInventoryModel.getList()})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    roomModel.deleteRow(index)
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Do you really want to delete this item?",
                    _title: "Confirm"
                }
                let _mbwin = _mb.createObject(roomPage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
