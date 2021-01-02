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
    width: 800
    height: 600
    visible: true
    title: qsTr("Tạo thông tin đặt phòng")
    color: "floralwhite"

    ListModel {
        id: reservationStateModel
        ListElement {
            value: 0
            text: qsTr("Chưa xác nhận")
        }
        ListElement {
            value: 1
            text: qsTr("Đã xác nhận")
        }
        ListElement {
            value: 2
            text: qsTr("Đã hủy bỏ")
        }
    }

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15


        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            Label {
                text: qsTr("Trạng thái:")
                font.bold: true
            }

            RowLayout {
                width: parent.width

                Label {
                    text: qsTr("Chọn trạng thái (*): ")
                }

                ComboBox {
                    Layout.fillWidth: true
                    id: stateCombobox
                    model: reservationStateModel
                    textRole: "text"
                    valueRole: "value"
                    Layout.maximumWidth: 200
                }
            }

            Label {
                text: qsTr("Thông tin phòng:")
                font.bold: true
            }

            RowLayout {
                id: rowLayout1
                width: parent.width

                Label {
                    text: qsTr("Chọn phòng (*): ")
                }

                ComboBox {
                    Layout.fillWidth: true
                    id: chooseRoomCombobox
                    Layout.maximumWidth: 300
                }
            }

            Label {
                text: qsTr("Thời gian đặt phòng:")
                font.bold: true
            }

            RowLayout {
                width: parent.width

                Label {
                    text: qsTr("Ngày check-in: ")
                }

                HDatePicker {
                    Layout.fillWidth: true
                }

                Label {
                    text: qsTr("Ngày check-out: ")
                }

                HDatePicker {
                    Layout.fillWidth: true
                }
            }

            Label {
                text: qsTr("Thông tin khách hàng:")
                font.bold: true
            }

            RowLayout {
                width: parent.width

                Label {
                    text: qsTr("Chọn khách hàng (*): ")
                }

                ComboBox {
                    Layout.fillWidth: true
                    editable: true
                }

                Button {
                    text: qsTr("Tạo thêm khách")
                }
            }

            ColumnLayout {
                id: colLayout1
                width: parent.width
                spacing: 10
                Label {
                    text: qsTr("Ghi chú thêm: ")
                    font.bold: true
                    Layout.fillWidth: true
                }
                Flickable {
                    id: flickable1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    TextArea.flickable: TextArea {
                        selectByMouse: true
                        id: descriptionTextArea

                        text: qsTr("jell")
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

            Label {
                text: qsTr("Chi tiết thanh toán:")
                font.bold: true
            }

            RowLayout {
                id: rowLayout3
                width: parent.width

                Label {
                    text: qsTr("Đơn giá (*): ")
                }

                TextField {
                    id: priceTextField
                    Layout.fillWidth: true
                    selectByMouse: true
                    validator: IntValidator {top: 1000000000; bottom: 0;}
                    text: qsTr("0")
                    //placeholderText: qsTr("Text Field")
                }
                Label {
                    text: qsTr("Giảm giá: ")
                }

                TextField {
                    id: surchargeTextField
                    Layout.fillWidth: true
                    validator: IntValidator {top: 1000000000; bottom: 0;}
                    text: qsTr("0")
                    selectByMouse: true
                    //placeholderText: qsTr("Text Field")
                }

                Label {
                    text: qsTr("Thành tiền: ")
                }

                TextField {
                    id: totalTextField
                    Layout.fillWidth: true
                    enabled: false
                    text: qsTr("150.000 VND")
                }
            }



        }



        RowLayout {
            width: parent.width

            Button {
                text: qsTr("Check in")
                onClicked: {
                    root.close()
                }
            }
            Button {
                text: qsTr("Xuất hóa đơn")
                onClicked: {
                    root.close()
                }
            }
            Button {
                text: qsTr("Xóa bỏ")
                onClicked: {
                    root.close()
                }
            }

            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Lưu")
                onClicked: {
                    if (_mode == "add") {
                        let ok = roomTypeModel.addRow(
                                nameTextField.text,
                                singleBedTextField.text,
                                doubleBedTextField.text,
                                guestTextField.text,
                                descriptionTextArea.text,
                                priceTextField.text,
                                surchargeTextField.text)
                        if (ok)
                            console.log("success")
                    }
                    if (_mode == "edit") {
                        let ok = roomTypeModel.updateRow(
                                _recordId,
                                nameTextField.text,
                                singleBedTextField.text,
                                doubleBedTextField.text,
                                guestTextField.text,
                                descriptionTextArea.text,
                                priceTextField.text,
                                surchargeTextField.text)
                        if (ok)
                            console.log("success")
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
            nameTextField.text = roomTypeModel.get(_recordId).name
            singleBedTextField.text = roomTypeModel.get(_recordId).singleBeds
            doubleBedTextField.text = roomTypeModel.get(_recordId).doubleBeds
            guestTextField.text = roomTypeModel.get(_recordId).guests
            priceTextField.text = roomTypeModel.get(_recordId).price
            surchargeTextField.text = roomTypeModel.get(_recordId).surcharge
            descriptionTextArea.text = roomTypeModel.get(_recordId).description
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
