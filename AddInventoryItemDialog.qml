import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0

Window {
    property string _mode: "add"
    property int _recordId: -1
    id: root
    width: 400
    height: 180
    visible: true
    title: qsTr("Tạo/Sửa đồ dùng")
    color: "#f8f8f8"
    modality: Qt.WindowModal

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15
        Label {
            id: label
            text: qsTr("Tên món đồ (*): ")
        }

        TextField {
            selectByMouse: true
            Layout.fillWidth: true
            id: nameTextField
            maximumLength: 100
            //placeholderText: qsTr("Text Field")
        }

        RowLayout {
            width: parent.width
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Lưu")
                onClicked: {
                    if (_mode == "add") {
                        let ok = inventoryModel.addRow(
                                nameTextField.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let ok = inventoryModel.updateRow(
                                _recordId,
                                nameTextField.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                }
            }

            Button {
                text: qsTr("Đóng")
                onClicked: {
                    root.close()
                }
            }
        }
    }
    Component.onCompleted: {
        if (_recordId >= 0) {
            nameTextField.text = inventoryModel.get(_recordId).name
        }
    }
}
