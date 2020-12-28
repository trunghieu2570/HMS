import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "qrc:/"

//Page: UserAccountListPage
Rectangle {
    id: userAccountPage
    property variant _win
    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
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
            id: userAccountTable
            flickableDirection: Flickable.VerticalFlick
            _height: 80
            _model: userAccountModel
            columnWidthProvider: function(column) {
                let columns = [0,80,200,200,120,0,0,0,0,0,userAccountTable.width - 700]
                return columns[column]
            }
            onEditButtonClicked: function(index) {
                var _com = Qt.createComponent("qrc:/dialogs/AddUserAccountDialog.qml")
                _win = _com.createObject(userAccountPage, {_recordId: index, _mode: "edit"})
                _win.show()
            }
            onDeleteButtonClicked: function(index) {
                let _onAccepted = function() {
                    userAccountModel.deleteRow(index)
                    _mbwin.destroy()
                }
                let _mb = Qt.createComponent("qrc:/MessageBox.qml")
                let _properties = {
                    _message: "Do you really want to delete this item?",
                    _title: "Confirm"
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
