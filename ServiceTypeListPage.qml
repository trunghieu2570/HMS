import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.2
import "qrc:/"

//Page: ServiceType List
Rectangle {
    id: serviceTypePage
    property variant _win


    SortFilterProxyModel {
        id: serviceTypeProxyModel
        sourceModel: serviceTypeModel
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
                text: qsTr("Thêm mới")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddServiceTypeDialog.qml")
                    _win = _com.createObject(serviceTypePage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Làm mới")
                onClicked: {
                    serviceTypeModel.populate()
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }
            TextField {
                id: searchTextField
                height: 30
                selectByMouse: true
                placeholderText: qsTr("Tìm loại dịch vụ...")
            }
            Button {
                text: qsTr("Xóa bộ lọc")
                onClicked: {
                    searchTextField.text = qsTr("")
                }
            }
        }
        HTableView {
            id: serviceTypeTable
            _model: serviceTypeProxyModel
            columnWidthProvider: function(column) {
                let columns = [100,200,serviceTypeTable.width - 400,0]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                var _com = Qt.createComponent("qrc:/dialogs/AddServiceTypeDialog.qml")
                _win = _com.createObject(serviceTypePage, {_recordId: serviceTypeProxyModel.mapToSource(index), _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    serviceTypeModel.deleteRow(serviceTypeProxyModel.mapToSource(index))
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Bạn thật sự muốn xóa loại dịch vụ này?",
                    _title: "Xác nhận"
                }
                let _mbwin = _mb.createObject(serviceTypePage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
