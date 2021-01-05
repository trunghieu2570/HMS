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
    height: 400
    visible: true
    title: qsTr("Thêm/Sửa loại dịch vụ")
    color: "#f8f8f8"
    modality: Qt.WindowModal

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        ColumnLayout {
            id: rowLayout1
            width: parent.width

            Label {
                id: label
                text: qsTr("Tên loại (*): ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                id: nameTextField
            }
        }
        ColumnLayout {
            id: colLayout1
            width: parent.width
            spacing: 10
            Label {
                text: qsTr("Mô tả: ")
                Layout.fillWidth: true
            }
            Flickable {
                id: flickable1
                Layout.fillWidth: true
                Layout.fillHeight: true
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
        ColumnLayout {
            id: rowLayout3
            width: parent.width

            Label {
                text: qsTr("Giá cơ bản (VND): ")
            }

            TextField {
                id: priceTextField
                Layout.fillWidth: true
                selectByMouse: true
                validator: IntValidator {top: 1000000000; bottom: 0;}
                text: qsTr("0")
                //placeholderText: qsTr("Text Field")
            }
        }
        RowLayout {
            width: parent.width
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Lưu lại")
                onClicked: {
                    if (_mode == "add") {
                        let ok = serviceTypeModel.add(
                                    nameTextField.text,
                                    descriptionTextArea.text,
                                    priceTextField.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let ok = serviceTypeModel.update(
                                _recordId,
                                nameTextField.text,
                                descriptionTextArea.text,
                                priceTextField.text)
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
            nameTextField.text = serviceTypeModel.get(_recordId).name
            priceTextField.text = serviceTypeModel.get(_recordId).basePrice
            descriptionTextArea.text = serviceTypeModel.get(_recordId).description
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.659999966621399}
}
##^##*/
