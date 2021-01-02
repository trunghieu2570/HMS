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
    height: 300
    visible: true
    title: qsTr("Thêm một dịch vụ")
    color: "floralwhite"
    modality: Qt.WindowModal

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        ColumnLayout {
            id: rowLayout1
            width: parent.width
            spacing: 10
            Label {
                id: label
                text: qsTr("Loại dịch vụ: ")
            }

            ComboBox {
                id: serviceTypeCbb
                Layout.fillWidth: true

                model: serviceTypeModel
                textRole: "name"
                valueRole: "id"
            }

            Label {
                text: qsTr("Nội dung: ")
            }

            Flickable {
                id: flickable1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: 100
                TextArea.flickable: TextArea {
                    selectByMouse: true
                    id: descriptionTextArea
                    wrapMode: TextEdit.Wrap
                    background: Rectangle {
                        color:  "white"
                        border.color: descriptionTextArea.focus ? "mediumblue" : "darkgrey"
                        border.width: descriptionTextArea.focus ? 2 : 1
                    }

                }
                ScrollBar.vertical: ScrollBar  {}
            }
        }

        RowLayout {
            width: parent.width
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Thêm")
                onClicked: {
                    if (_mode == "add") {
                        for (let i = 0; i < usingServiceModel.rowCount(); i++ ) {
                            if (serviceTypeCbb.currentValue === usingServiceModel.data(usingServiceModel.index(i,0))) {
                                usingServiceModel.removeRow(i)
                            }
                        }

                        let ok = usingServiceModel.addRow(
                                serviceTypeCbb.currentValue,
                                serviceTypeCbb.currentValue,
                                serviceTypeCbb.currentText,
                                serviceTypeModel.get(serviceTypeCbb.currentValue).basePrice,
                                descriptionTextArea.text
                                )
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
