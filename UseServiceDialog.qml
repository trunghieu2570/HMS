import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0
import Qt.labs.qmlmodels 1.0
import "qrc:/"

Window {
    property string _mode: "add"
    property int _recordId: -1
    property string currentReservationId
    property variant _win
    id: root
    width: 800
    height: 800
    visible: true
    title: qsTr("Tạo phiếu dịch vụ")
    color: "floralwhite"

    function calMoney() {
        let sum = 0
        for (let i = 0; i < usingServiceModel.rowCount(); i++ ) {
            sum += usingServiceModel.data(usingServiceModel.index(i,3))
        }
        priceTextField.text = sum
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
                text: qsTr("Phiếu dịch vụ:")
                font.bold: true
            }

            RowLayout {
                width: parent.width

                Label {
                    text: qsTr("Mã phiếu đặt phòng:")
                }

                TextField {
                    id: textField
                    text: "000001"
                    font.bold: true
                    enabled: false
                    placeholderText: qsTr("Tự động sinh")
                }

            }

            Label {
                text: qsTr("Chi tiết dịch vụ:")
                font.bold: true
            }

            RowLayout {
                id: rowLayout1
                width: parent.width

                Button {
                    id: button
                    text: qsTr("Thêm dịch vụ")
                    onClicked: {
                        var _com = Qt.createComponent("qrc:/dialogs/DetailUseServiceDialog.qml")
                        root._win = _com.createObject(root)
                        root._win.show()
                        //usingServiceModel.addRow(hTableView.rows, 1, "hello", 200000, "fhufjsdifjisd")
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "#e0e0e0"
                Layout.minimumHeight: 200

                HTableView {
                    id: hTableView
                    _editable: false
                    _model: usingServiceModel
                    anchors.fill: parent
                    onContentHeightChanged: {
                        calMoney()
                    }
                    columnWidthProvider: function(column) {
                        let columns = [0,0,200,100,hTableView.width - 400]
                        return columns[column]
                    }

                    onDeleteButtonClicked: function(index) {
                        usingServiceModel.removeRow(index)
                    }
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

            Label {
                text: qsTr("Chi tiết thanh toán:")
                font.bold: true
            }

            RowLayout {
                id: rowLayout3
                width: parent.width

                Label {
                    text: qsTr("Thành tiền: ")
                }

                TextField {
                    id: priceTextField
                    Layout.fillWidth: true
                    text: qsTr("0")
                    enabled: false
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
                    text: qsTr("Số tiền phải trả: ")
                }

                TextField {
                    id: totalTextField
                    color: "black"
                    font.bold: true
                    Layout.fillWidth: true
                    enabled: false
                    text: qsTr("150.000 VND")
                }
            }




        }



        RowLayout {
            width: parent.width

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
    D{i:0;formeditorZoom:1.25}
}
##^##*/
