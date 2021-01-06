import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.2
import "qrc:/"

//Page: UserAccountListPage
Rectangle {
    id: userAccountPage
    property variant _win

    SortFilterProxyModel {
        id: userAccountProxyModel
        sourceModel: userAccountModel
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
                enabled: authenticationService.currentUserRole > 1
                text: qsTr("Thêm mới")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/AddUserAccountDialog.qml")
                    _win = _com.createObject(userAccountPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Làm mới")
                onClicked: {
                    userAccountModel.populate()
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
            id: userAccountTable
            _editable: authenticationService.currentUserRole > 1
            _removable: authenticationService.currentUserRole > 1
            flickableDirection: Flickable.VerticalFlick
            _height: 80
            _model: userAccountProxyModel
            columnWidthProvider: function(column) {
                let columns = [0,80,200,200,120,0,0,0,0,0,userAccountTable.width - 700]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                var _com = Qt.createComponent("qrc:/dialogs/AddUserAccountDialog.qml")
                _win = _com.createObject(userAccountPage, {_recordId: userAccountProxyModel.mapToSource(index), _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    userAccountModel.remove(userAccountProxyModel.mapToSource(index))
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Bạn thật sự muốn xóa tài khoản này?",
                    _title: "Xác nhận"
                }
                let _mbwin = _mb.createObject(userAccountPage, _properties)
                _mbwin.accepted.connect(_onAccepted)
                _mbwin.show()
            }
            delegate: Rectangle {
                id: cell
                implicitHeight: userAccountTable._height
                color: row % 2 != 0 ? "mintcream" : "white"
                ListModel {
                    id: roleModel
                    ListElement {
                        value: 0
                        text: qsTr("Nhân viên")
                    }
                    ListElement {
                        value: 1
                        text: qsTr("Quản lý")
                    }
                    ListElement {
                        value: 2
                        text: qsTr("Giám đốc")
                    }
                    ListElement {
                        value: 3
                        text: qsTr("Quản trị viên")
                    }
                }
                Loader {
                    anchors.fill: parent
                    sourceComponent: {column === 1 ? imageCell : textCell}
                    Component {
                        id: imageCell
                        Rectangle {
                            color: "grey"
                            anchors.margins: 10
                            anchors.fill: parent
                            width: 60
                            height: 80
                            Image {
                                anchors.fill: parent
                                source: "qrc:/icons/Icons/White/user_64px.png"
                            }
                            Image {
                                cache: false
                                anchors.fill: parent
                                source: "image://avatar/" + userAccountTable._model.data(userAccountTable._model.index(row, 0))
                            }
                        }
                    }
                    Component {
                        id: textCell
                        Text {
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.margins: 10
                            text: {
                                if(column === 4){
                                    return roleModel.get(parseInt(userAccountTable._model.data(userAccountTable._model.index(row, column)))).text
                                } else
                                    return userAccountTable._model.data(userAccountTable._model.index(row, column))
                            }
                            property bool hovered: false
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                ToolTip.delay: 1000
                                ToolTip.visible: containsMouse
                                ToolTip.text: userAccountTable._model.data(userAccountTable._model.index(row, column))
                            }
                        }
                    }


                }


            }
        }
    }

}
