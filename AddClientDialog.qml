import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0
import "qrc:/"

Window {
    property string _mode: "add"
    property int _recordId: -1
    id: root
    width: 600
    height: 500
    visible: true
    title: qsTr("Thông tin khách hàng")
    color: "#f8f8f8"
    modality: Qt.WindowModal


    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        GridLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            rows: 5
            columns: 4

            Label {
                id: label
                text: qsTr("Tên đầy đủ (*):")
                Layout.columnSpan: 1
            }

            TextField {
                id: fullNameTextField
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.rowSpan: 1
                Layout.columnSpan: 3
                selectByMouse: true
            }

            Label {
                id: label2
                text: qsTr("Giới tính (*):")
            }

            ComboBox {
                id: genderComboBox
                Layout.fillWidth: true
                model: ["Nữ", "Nam"]
            }

            Label {
                id: label3
                text: qsTr("Ngày sinh (*): ")

            }

            HDatePicker {
                id: birthdayDatePicker
                selectByMouse: true
                Layout.fillWidth: true
                placeholderText: qsTr("DD/MM/YYYY")
            }

            Label {
                id: label1
                text: qsTr("Địa chỉ:")
                Layout.rowSpan: 1
                Layout.columnSpan: 1
            }

            TextField {
                id: addressTextField
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.rowSpan: 1
                Layout.columnSpan: 3
                selectByMouse: true
            }

            Label {
                id: label4
                text: qsTr("Số điện thoại:")
            }

            TextField {
                id: phoneNumberTextField
                Layout.fillWidth: true
                selectByMouse: true
            }

            Label {
                id: label5
                text: qsTr("Email:")
            }

            TextField {
                id: emailTextField
                Layout.fillWidth: true
                selectByMouse: true
            }

            Label {
                id: label6
                text: qsTr("Số CMT:")
            }

            TextField {
                id: identityNumberTextField
                Layout.fillWidth: true
                selectByMouse: true
            }

            Label {
                id: label7
                text: qsTr("Quốc tịch:")
            }

            ComboBox {
                id: nationalityComboBox
                Layout.fillWidth: true
                model: ["Viet Nam"]
            }

            Label {
                id: label9
                text: qsTr("Ghi chú:")
            }

            Flickable {
                id: flickable1
                Layout.columnSpan: 3
                Layout.rowSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                TextArea.flickable: TextArea {
                    selectByMouse: true
                    id: commentTextArea
                    wrapMode: TextEdit.Wrap
                    background: Rectangle {
                        color:  "white"
                        border.color: commentTextArea.focus ? "mediumblue" : "darkgrey"
                        border.width: commentTextArea.focus ? 2 : 1
                    }

                }
                ScrollBar.vertical: ScrollBar  {}
            }
        }

        RowLayout {
            width: parent.width
            Layout.fillHeight: false
            Layout.fillWidth: true
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Lưu")
                onClicked: {
                    if (_mode == "add") {
                        let ok = clientModel.addRow(
                                fullNameTextField.text,
                                birthdayDatePicker._selectedDate,
                                genderComboBox.currentText === "Nam",
                                emailTextField.text,
                                addressTextField.text,
                                phoneNumberTextField.text,
                                nationalityComboBox.currentText,
                                identityNumberTextField.text,
                                commentTextArea.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let ok = clientModel.updateRow(
                                _recordId,
                                fullNameTextField.text,
                                birthdayDatePicker._selectedDate,
                                genderComboBox.currentText === "Nam",
                                emailTextField.text,
                                addressTextField.text,
                                phoneNumberTextField.text,
                                nationalityComboBox.currentText,
                                identityNumberTextField.text,
                                commentTextArea.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                }
            }

            Button {
                text: qsTr("Hủy")
                onClicked: {
                    root.close()
                }
            }
        }




    }
    Component.onCompleted: {
        if (_recordId >= 0) {
            fullNameTextField.text = clientModel.get(_recordId).name
            birthdayDatePicker._selectedDate = clientModel.get(_recordId).birthday
            genderComboBox.currentIndex = clientModel.get(_recordId).gender ? 1 : 0
            emailTextField.text = clientModel.get(_recordId).email
            addressTextField.text = clientModel.get(_recordId).address
            phoneNumberTextField.text = clientModel.get(_recordId).phoneNumber
            nationalityComboBox.currentIndex = nationalityComboBox.find(clientModel.get(_recordId).nationality)
            identityNumberTextField.text = clientModel.get(_recordId).identityNumber
            commentTextArea.text = clientModel.get(_recordId).comments
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
