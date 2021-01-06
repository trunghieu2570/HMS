import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.2
import "qrc:/"

//Page: Inventory List
Rectangle {
    id: inventoryPage
    property variant _win

    SortFilterProxyModel {
        id: inventoryProxyTable
        sourceModel: inventoryModel
        filters: RegExpFilter {
            roleName: "name"
            pattern: searchTextField.text
            caseSensitivity: Qt.CaseInsensitive
        }
    }

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                enabled: authenticationService.currentUserRole > 0
                text: qsTr("Thêm")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddInventoryItemDialog.qml")
                    _win = _com.createObject(inventoryPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Làm mới")
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
                placeholderText: qsTr("Nhập tên đồ dùng...")
            }
            Button {
                text: qsTr("Xóa bộ lọc")
                onClicked: {
                    searchTextField.text = qsTr("")
                }
            }
        }
        HTableView {
            id: inventoryTable
            _model: inventoryProxyTable
            _editable: authenticationService.currentUserRole > 0
            _removable: authenticationService.currentUserRole > 0
            columnWidthProvider: function(column) {
                let columns = [100,inventoryTable.width - 200]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                let _com = Qt.createComponent("qrc:/dialogs/AddInventoryItemDialog.qml")
                _win = _com.createObject(inventoryPage, {_recordId: inventoryProxyTable.mapToSource(index), _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    inventoryModel.deleteRow(inventoryProxyTable.mapToSource(index))
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Bạn thật sự muốn xóa đồ dùng này?",
                    _title: "Xác nhận"
                }
                let _mbwin = _mb.createObject(inventoryPage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
