import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "qrc:/"

//Page: RoomType List
Rectangle {
    id: roomTypePage
    property variant _win
    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                text: qsTr("Add New Type")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddRoomTypeDialog.qml")
                    _win = _com.createObject(roomTypePage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Refresh")
                onClicked: {
                    roomTypeModel.populate()
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }
            TextField {

                height: 30
                selectByMouse: true
                placeholderText: qsTr("Find some thing...")
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("GO")
            }
        }
        HTableView {
            id: roomTypeTable
            _model: roomTypeModel
            columnWidthProvider: function(column) {
                let columns = [100,200,0,0,0,0,0,roomTypeTable.width - 400]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                var _com = Qt.createComponent("qrc:/dialogs/AddRoomTypeDialog.qml")
                _win = _com.createObject(roomTypePage, {_recordId: index, _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    roomTypeModel.deleteRow(index)
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Do you really want to delete this item?",
                    _title: "Confirm"
                }
                let _mbwin = _mb.createObject(roomTypePage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
        }
    }

}
