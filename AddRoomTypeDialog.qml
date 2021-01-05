import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0

Window {
    property string _mode: "add"
    property int _recordId: -1
    modality: Qt.WindowModal
    id: root
    width: 600
    height: 400
    visible: true
    title: qsTr("Thông tin loại phòng")
    color: "#f8f8f8"

    ColumnLayout {
        id: col
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        RowLayout {
            id: rowLayout1
            width: parent.width

            Label {
                id: label
                text: qsTr("Tên loại phòng: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                id: nameTextField
                //placeholderText: qsTr("Text Field")
            }
        }

        RowLayout {
            id: rowLayout2
            width: parent.width

            Label {
                text: qsTr("Số giường đơn: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                inputMethodHints: "ImhDigitsOnly"
                id: singleBedTextField
                validator: IntValidator {top: 100; bottom: 0;}
                text: qsTr("0")
                //placeholderText: qsTr("Text Field")
            }
            Label {
                text: qsTr("Số giường đôi: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                inputMethodHints: "ImhDigitsOnly"
                id: doubleBedTextField
                text: qsTr("0")
                validator: IntValidator {top: 100; bottom: 0;}
                //placeholderText: qsTr("Text Field")
            }
            Label {
                text: qsTr("Số khách: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                id: guestTextField
                inputMethodHints: "ImhDigitsOnly"
                text: qsTr("0")
                validator: IntValidator {top: 300; bottom: 0;}
                //placeholderText: qsTr("Text Field")
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
        RowLayout {
            id: rowLayout3
            width: parent.width

            Label {
                text: qsTr("Giá phòng: ")
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
                text: qsTr("Phụ thu: ")
            }

            TextField {
                id: surchargeTextField
                Layout.fillWidth: true
                validator: IntValidator {top: 1000000000; bottom: 0;}
                text: qsTr("0")
                selectByMouse: true
                //placeholderText: qsTr("Text Field")
            }
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
                        let ok = roomTypeModel.addRow(
                                    nameTextField.text,
                                    singleBedTextField.text,
                                    doubleBedTextField.text,
                                    guestTextField.text,
                                    descriptionTextArea.text,
                                    priceTextField.text,
                                    surchargeTextField.text)
                        if (ok) {
                            console.log("success")
                            root.close()
                        }
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
    D{i:0;formeditorZoom:1.659999966621399}
}
##^##*/
