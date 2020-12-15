import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as Old
import hms.dto 1.0
import "qrc:/"

Window {
    property string _mode: "add"
    property int _recordId: -1
    id: root
    width: 600
    height: 600
    visible: true
    title: qsTr("Add/Modify Guest")
    color: "floralwhite"



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
                id: label8
                text: qsTr("ID")
            }

            TextField {
                id: textField8
                text: "0000001"
                enabled: false
                //hoverEnabled: false
                Layout.columnSpan: 3
            }

            Label {
                id: label
                text: qsTr("Full Name:")
                Layout.columnSpan: 1
            }

            TextField {
                id: textField
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.rowSpan: 1
                Layout.columnSpan: 3
                placeholderText: qsTr("Text Field")
            }



            Label {
                id: label2
                text: qsTr("Gender:")
            }

            TextField {
                id: textField2
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label3
                text: qsTr("Birthday: ")

            }

            HDatePicker {
                id: textField3
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label1
                text: qsTr("Address:")
                Layout.rowSpan: 1
                Layout.columnSpan: 1
            }

            TextField {
                id: textField1
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.rowSpan: 1
                Layout.columnSpan: 3
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label4
                text: qsTr("Phone Number:")
            }

            TextField {
                id: textField4
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label5
                text: qsTr("Email:")
            }

            TextField {
                id: textField5
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label6
                text: qsTr("ID / Passport:")
            }

            TextField {
                id: textField6
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label7
                text: qsTr("Nationality:")
            }

            TextField {
                id: textField7
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }

            Label {
                id: label9
                text: qsTr("Comments:")
            }

            TextArea {
                id: textArea
                wrapMode: Text.Wrap
                //topInset: 1
                Layout.columnSpan: 3
                Layout.rowSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                //placeholderText: qsTr("Text Area")
                //                background: Rectangle {
                //                    color: "white"
                //                }
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
                text: qsTr("Save and Create New")
            }

            Button {
                text: qsTr("Save")
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
                text: qsTr("Cancel")
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
