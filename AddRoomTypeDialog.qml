import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Window {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("Add/Modify Room Type")
    color: "floralwhite"
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
                text: qsTr("Type Name: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                id: textField
                //placeholderText: qsTr("Text Field")
            }
        }

        RowLayout {
            id: rowLayout2
            width: parent.width

            Label {
                text: qsTr("Single beds: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                inputMethodHints: "ImhDigitsOnly"
                validator: IntValidator {top: 100; bottom: 0;}
                text: qsTr("0")
                //placeholderText: qsTr("Text Field")
            }
            Label {
                text: qsTr("Double beds: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
                inputMethodHints: "ImhDigitsOnly"
                text: qsTr("0")
                validator: IntValidator {top: 100; bottom: 0;}
                //placeholderText: qsTr("Text Field")
            }
            Label {
                text: qsTr("Guests: ")
            }

            TextField {
                selectByMouse: true
                Layout.fillWidth: true
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
                text: qsTr("Description: ")
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
        RowLayout {
            id: rowLayout3
            width: parent.width

            Label {
                text: qsTr("Price: ")
            }

            TextField {
                Layout.fillWidth: true
                selectByMouse: true
                validator: IntValidator {top: 1000000000; bottom: 0;}
                text: qsTr("0")
                //placeholderText: qsTr("Text Field")
            }
            Label {
                text: qsTr("Surcharge: ")
            }

            TextField {
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
                text: qsTr("Save and Create New")
            }

            Button {
                text: qsTr("Save")
            }

            Button {
                text: qsTr("Cancel")
                onClicked: {
                    root.close()
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.659999966621399}
}
##^##*/
