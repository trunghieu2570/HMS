import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
//import QtQuick.Controls 1.4 as Old
import hms.dto 1.0
import QtQuick.Dialogs 1.0
import "qrc:/"

Window {
    property string _mode: "add"
    property int _recordId: -1
    id: root
    width: 800
    height: 420
    visible: true
    title: qsTr("Thêm/Sửa tài khoản")
    color: "floralwhite"
    modality: Qt.WindowModal

    FileDialog {
        id: fileDialog
        title: "Please choose a image"
        folder: shortcuts.home
        nameFilters: [ "Image files (*.jpg *.png)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            avatarImage.source = fileDialog.fileUrls[0]
            visible = false
        }
        onRejected: {
            console.log("Canceled")
            visible = false
        }
        //Component.onCompleted: visible = true
    }

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20
            ColumnLayout {
                id: columnLayout
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Label {
                    id: label11
                    text: qsTr("Ảnh đại diện:")
                }
                Rectangle {
                    width: 150
                    height: 200
                    border.color: "black"
                    border.width: 1
                    Image {
                        anchors.fill: parent
                        id: avatarImage
                        source: "qrc:/qtquickplugin/images/template_image.png"
                    }
                }
                Button {
                    text: qsTr("Thay đổi ảnh...")
                    onClicked: {
                        fileDialog.visible = true
                    }
                }
            }
            GridLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: true
                Layout.fillWidth: true
                rows: 5

                columns: 4

                Label {
                    id: label
                    text: qsTr("Họ và tên (*):")
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
                    id: label8
                    text: qsTr("Tên người dùng (*):")
                }

                TextField {
                    id: usernameTextField
                    Layout.columnSpan: 3
                    Layout.fillWidth: true
                }

                Label {
                    id: label10
                    text: qsTr("Mật khẩu (*):")
                }

                TextField {
                    id: passwordTextField
                    Layout.fillWidth: true
                    selectByMouse: true
                }

                Label {
                    id: label9
                    text: qsTr("Nhập lại (*):")
                }

                TextField {
                    id: confirmPasswordTextField
                    Layout.fillWidth: true
                    selectByMouse: true
                }
                Label {
                    id: label12
                    text: qsTr("Chức vụ (*):")
                }
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

                ComboBox {
                    id: roleComboBox
                    model: roleModel
                    textRole: "text"
                    valueRole: "value"
                }
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
                text: qsTr("Lưu lại")
                onClicked: {
                    if (_mode == "add") {
                        let ok = userAccountModel.add(
                                avatarImage.source,
                                usernameTextField.text,
                                passwordTextField.text,
                                fullNameTextField.text,
                                parseInt(roleComboBox.currentValue),
                                genderComboBox.currentText === "Nữ",
                                birthdayDatePicker._selectedDate,
                                emailTextField.text,
                                addressTextField.text,
                                phoneNumberTextField.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let ok = userAccountModel.update(
                                userAccountModel.get(_recordId).id,
                                avatarImage.source,
                                passwordTextField.text,
                                fullNameTextField.text,
                                parseInt(roleComboBox.currentValue),
                                genderComboBox.currentText === "Nữ",
                                birthdayDatePicker._selectedDate,
                                emailTextField.text,
                                addressTextField.text,
                                phoneNumberTextField.text)
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
            let account = userAccountModel.get(_recordId)
            avatarImage.source = "image://avatar/" + account.id
            fullNameTextField.text = account.name
            birthdayDatePicker._selectedDate = account.birthday
            genderComboBox.currentIndex = account.gender ? 1 : 0
            emailTextField.text = account.email
            addressTextField.text = account.address
            phoneNumberTextField.text = account.phoneNumber
            usernameTextField.text = account.username
            usernameTextField.enabled = false
            roleComboBox.currentIndex = roleComboBox.indexOfValue(account.role)
        }
    }
}


