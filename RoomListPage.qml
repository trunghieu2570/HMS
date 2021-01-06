import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.2
import "qrc:/"
import "qrc:/dialogs"

//Page: Client List
Rectangle {
    id: roomPage
    property variant _win

    SortFilterProxyModel {
        id: roomProxyModel
        sourceModel: roomModel
        filters:[
            RegExpFilter {
                roleName: "name"
                pattern: searchTextField.text
                caseSensitivity: Qt.CaseInsensitive
            },
            ValueFilter {
                roleName: "room_type_id"
                value: roomTypeCbb.currentValue
            }

        ]
    }


    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                enabled: authenticationService.currentUserRole > 0
                text: qsTr("Tạo phòng")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddRoomDialog.qml")
                    _win = _com.createObject(roomPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Làm mới")
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
                placeholderText: qsTr("Tìm mã số phòng...")
            }
            ComboBox {
                Layout.preferredWidth: 160
                id: roomTypeCbb
                model: roomTypeModel
                textRole: "name"
                valueRole: "id"
                currentIndex: -1
                displayText: currentIndex === -1 ? "Chọn loại phòng" : currentText
            }
            Button {
                text: qsTr("Xóa bộ lọc")
                onClicked: {
                    searchTextField.text = qsTr("")
                    roomTypeCbb.currentIndex = -1
                }
            }
        }
        HTableView {
            id: roomTable
            _model: roomProxyModel
            _editable: authenticationService.currentUserRole > 0
            _removable: authenticationService.currentUserRole > 0
            columnWidthProvider: function(column) {
                let columns = [0,100,0,200,0,0,roomTable.width - 400]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                let _com = Qt.createComponent("qrc:/dialogs/AddRoomDialog.qml")
                roomInventoryModel.populate(roomModel.get(roomProxyModel.mapToSource(index)).id)
                _win = _com.createObject(roomPage, {_recordId: roomProxyModel.mapToSource(index), _mode: "edit", _selectedInventoryItems: roomInventoryModel.getList()})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    roomModel.deleteRoom(roomProxyModel.mapToSource(index))
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Bạn thật sự muốn xóa phòng này?",
                    _title: "Xác nhận"
                }
                let _mbwin = _mb.createObject(roomPage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
