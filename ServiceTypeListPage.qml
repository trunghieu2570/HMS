import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "qrc:/"

//Page: ServiceType List
Rectangle {
    id: serviceTypePage
    property variant _win
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

                height: 30
                selectByMouse: true
                placeholderText: qsTr("Nhập từ khóa...")
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("Tìm")
            }
        }
        HTableView {
            id: serviceTypeTable
            _model: serviceTypeModel
            columnWidthProvider: function(column) {
                let columns = [100,200,serviceTypeTable.width - 400,0]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                var _com = Qt.createComponent("qrc:/dialogs/AddServiceTypeDialog.qml")
                _win = _com.createObject(serviceTypePage, {_recordId: index, _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    serviceTypeModel.deleteRow(index)
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Do you really want to delete this item?",
                    _title: "Confirm"
                }
                let _mbwin = _mb.createObject(serviceTypePage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
