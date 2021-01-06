import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0
import "qrc:/"

Window {
    property string _mode: "add"
    property int resId: -1
    id: root
    width: 1200
    height: 700
    visible: true
    title: qsTr("Thông tin đặt phòng")
    color: "floralwhite"
    modality: Qt.WindowModal
    property var _win

    function changeServicePrice() {
        let sum = 0
        for (let i = 0; i < usingServiceModel.rowCount(); i++ ) {
            sum += usingServiceModel.data(usingServiceModel.index(i,3))
        }
        servicePriceTextField.text = sum
    }

    function changeTotalPrice() {
        let ndate = checkOutDate._selectedDate.getDate() - checkInDate._selectedDate.getDate();
        let sum = parseInt(priceTextField.text) * (ndate < 1 ? 1 : ndate) + parseInt(servicePriceTextField.text) - parseInt(discountTextField.text)
        totalTextField.text = sum + " VND"
    }

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
            text: qsTr("Đã chiếm chỗ")
        }
        ListElement {
            value: 3
            text: qsTr("Đã hủy bỏ")
        }
    }

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 20
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
                        model: roomModel
                        textRole: "name"
                        valueRole: "id"
                        Layout.fillWidth: true
                        id: chooseRoomCombobox
                        Layout.maximumWidth: 300
                        onActivated: {
                            console.log(currentValue)
                            console.log(roomModel.getType(currentValue).price)
                            priceTextField.text = roomModel.getType(currentValue).price
                        }
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
                        id: checkInDate
                        onTextChanged: {
                            changeTotalPrice()
                        }
                    }

                    Label {
                        text: qsTr("Ngày check-out: ")
                    }

                    HDatePicker {
                        Layout.fillWidth: true
                        id: checkOutDate
                        onTextChanged: {
                            changeTotalPrice()
                        }
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
                        id: chooseClientCbb
                        model: clientModel
                        Layout.fillWidth: true
                        editable: true
                        textRole: "name"
                        valueRole: "id"
                        currentIndex: -1
                    }

                    Button {
                        text: qsTr("Tạo thêm khách")
                        onClicked: {
                            var _com = Qt.createComponent("qrc:/dialogs/AddClientDialog.qml")
                            _win = _com.createObject(root)
                            _win.show()
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
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: 10
                Label {
                    text: qsTr("Thông tin chung:")
                    font.bold: true
                }

                RowLayout {
                    width: parent.width

                    Label {
                        text: qsTr("Ngày tạo:")
                    }

                    TextField {
                        text: (new Date).toLocaleDateString(Qt.locale(), "d/M/yyyy")
                        enabled: false
                        color: "black"
                    }

                    Label {
                        text: qsTr("Người tạo:")
                    }

                    TextField {
                        id: creatorUserTextField
                        text: authenticationService.currentUserName
                        enabled: false
                        color: "black"
                    }

                }

                Label {
                    text: qsTr("Chi tiết dịch vụ:")
                    font.bold: true
                }

                RowLayout {
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
                            changeServicePrice()
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

                Label {
                    text: qsTr("Chi tiết thanh toán:")
                    font.bold: true
                }

                RowLayout {
                    id: rowLayout3
                    width: parent.width

                    Label {
                        text: qsTr("Đơn giá phòng(*): ")
                    }

                    TextField {
                        id: priceTextField
                        Layout.fillWidth: true
                        selectByMouse: true
                        validator: IntValidator {top: 1000000000; bottom: 0;}
                        text: qsTr("0")
                        onTextChanged: {
                            changeTotalPrice()
                        }

                    }

                    Label {
                        text: qsTr("Tổng phí dịch vụ: ")
                    }

                    TextField {
                        id: servicePriceTextField
                        Layout.fillWidth: true
                        color: "black"
                        text: qsTr("0")
                        enabled: false
                        onTextChanged: {
                            changeTotalPrice()
                        }
                    }
                }

                RowLayout {
                    width: parent.width

                    Label {
                        text: qsTr("Giảm giá: ")
                    }

                    TextField {
                        id: discountTextField
                        Layout.fillWidth: true
                        validator: IntValidator {top: 1000000000; bottom: 0;}
                        text: qsTr("0")
                        selectByMouse: true
                        onTextChanged: {
                            changeTotalPrice()
                        }
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

        }





        RowLayout {
            width: parent.width

            Button {
                enabled: false
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
                        let returnId = roomCalendarModel.createReservation(
                                chooseRoomCombobox.currentValue,
                                checkInDate._selectedDate,
                                checkOutDate._selectedDate,
                                chooseClientCbb.currentValue,
                                parseInt(priceTextField.text),
                                parseInt(discountTextField.text),
                                stateCombobox.currentValue,
                                descriptionTextArea.text,
                                authenticationService.currentUserId
                                )
                        usingServiceModel.saveToDb(returnId)
                        console.log(returnId)
                        if (returnId > 0) {
                            console.log("success")
                            root.close()
                        }
                    }
                    if (_mode == "edit") {
                        let returnId = roomCalendarModel.updateReservation(
                                resId,
                                chooseRoomCombobox.currentValue,
                                checkInDate._selectedDate,
                                checkOutDate._selectedDate,
                                chooseClientCbb.currentValue,
                                parseInt(priceTextField.text),
                                parseInt(discountTextField.text),
                                stateCombobox.currentValue,
                                descriptionTextArea.text,
                                authenticationService.currentUserId
                                )
                        usingServiceModel.saveToDb(returnId)
                        console.log(returnId)
                        if (returnId > 0) {
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
        usingServiceModel.clear()
        if (resId >= 0) {
            usingServiceModel.loadFromDb(resId)
            let res = roomCalendarModel.getReservation(resId)

            chooseRoomCombobox.currentIndex = chooseRoomCombobox.indexOfValue(res.roomId)
            checkInDate._selectedDate = res.checkin
            checkOutDate._selectedDate = res.checkout
            chooseClientCbb.currentIndex = chooseClientCbb.indexOfValue(res.clientId)
            priceTextField.text = res.roomPrice
            discountTextField.text = res.discount
            stateCombobox.currentIndex = stateCombobox.indexOfValue(res.state)
            descriptionTextArea.text = res.note
            creatorUserTextField.text = res.userAccountName
            console.log(chooseRoomCombobox.currentIndex)
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
