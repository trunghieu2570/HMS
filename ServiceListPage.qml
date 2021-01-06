import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import SortFilterProxyModel 0.2
import "qrc:/"
import "qrc:/dialogs"

//Page: Service List
Rectangle {
    id: clientPage
    property variant _win

    SortFilterProxyModel {
        id: serviceProxyModel
        sourceModel: serviceModel
        filters:[
            RegExpFilter {
                roleName: "room"
                pattern: searchTextField.text
                caseSensitivity: Qt.CaseInsensitive
            },
            ValueFilter {
                roleName: "service_type_id"
                value: serviceTypeCbb.currentValue
            }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                text: qsTr("Làm mới")
                onClicked: {
                    serviceModel.populate()
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }
            TextField {
                id: searchTextField
                height: 30
                selectByMouse: true
                placeholderText: qsTr("Tìm theo phòng...")
            }
            ComboBox {
                Layout.preferredWidth: 160
                id: serviceTypeCbb
                model: serviceTypeModel
                textRole: "name"
                valueRole: "id"
                currentIndex: -1
                displayText: currentIndex === -1 ? "Chọn dịch vụ" : currentText
            }
            Button {
                text: qsTr("Xóa bộ lọc")
                onClicked: {
                    searchTextField.text = qsTr("")
                    serviceTypeCbb.currentIndex = -1
                }
            }
        }
        HTableView {
            id: serviceTable
            _model: serviceProxyModel
            _editable: false
            _removable: false

            _actionWidth: 0
            columnWidthProvider: function(column) {
                let columns = [0,200,100,100,200,serviceTable.width - 600]
                return columns[column]
            }

            delegate: Rectangle {
                id: cell
                implicitHeight: serviceTable._height
                clip: true
                color: row % 2 != 0 ? "mintcream" : "white"
                Text {
                    anchors.fill: parent
                    anchors.margins: 10
                    text: column !== 3 ? serviceTable._model.data(serviceTable._model.index(row, column)) : serviceTable._model.data(serviceTable._model.index(row, column)).toLocaleDateString(Qt.locale(), "dd/MM/yyyy")
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        ToolTip.delay: 1000
                        ToolTip.visible: containsMouse
                        ToolTip.text: serviceTable._model.data(serviceTable._model.index(row, column))
                    }
                }
            }
        }
    }

}
