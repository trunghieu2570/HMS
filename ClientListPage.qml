import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.2
import "qrc:/"
import "qrc:/dialogs"

//Page: Client List
Rectangle {
    id: clientPage
    property variant _win

    SortFilterProxyModel {
        id: clientProxyModel
        sourceModel: clientModel
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
                text: qsTr("Thêm khách hàng")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddClientDialog.qml")
                    _win = _com.createObject(clientPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Làm mới")
                onClicked: {
                    clientModel.populate()
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }
            TextField {
                id: searchTextField
                height: 30
                selectByMouse: true
                placeholderText: qsTr("Tìm kiếm theo tên")
            }
            Button {
                text: qsTr("Xóa bộ lọc")
                onClicked: {
                    searchTextField.text = qsTr("")
                }
            }
        }
        HTableView {
            id: clientTable
            _model: clientProxyModel
            columnWidthProvider: function(column) {
                let columns = [100,200,100,0,200,300,0,0,0,clientTable.width - 1000]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                let _com = Qt.createComponent("qrc:/dialogs/AddClientDialog.qml")
                _win = _com.createObject(clientPage, {_recordId: clientProxyModel.mapToSource(index), _mode: "edit"})
                _win.show()
            }

            delegate: Rectangle {
                id: cell
                implicitHeight: clientTable._height
                clip: true
                color: row % 2 != 0 ? "mintcream" : "white"
                Text {
                    anchors.fill: parent
                    anchors.margins: 10
                    text: column !== 2 ? clientTable._model.data(clientTable._model.index(row, column)) : clientTable._model.data(clientTable._model.index(row, column)).toLocaleDateString(Qt.locale(), "dd/MM/yyyy")
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        ToolTip.delay: 1000
                        ToolTip.visible: containsMouse
                        ToolTip.text: clientTable._model.data(clientTable._model.index(row, column))
                    }
                }
            }

            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    clientModel.deleteRow(clientProxyModel.mapToSource(index))
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Bạn thật sự một xóa phần tử này?",
                    _title: "Xác nhận"
                }
                let _mbwin = _mb.createObject(clientPage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
