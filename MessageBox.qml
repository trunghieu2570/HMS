import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0

Window {
    property string _message: qsTr("message_content")
    property string _title: qsTr("message_title")

    signal accepted()
    signal rejected()

    flags: Qt.Dialog

    id: root
    width: 400
    height: 130
    visible: true
    title: _title
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
                Layout.fillWidth: true
                text: _message
            }
        }

        RowLayout {
            width: parent.width
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("OK")
                onClicked: {
                    accepted()
                    root.close()
                }
            }

            Button {
                text: qsTr("Cancel")
                onClicked: {
                    rejected()
                    root.close()
                }
            }
        }
    }
    Component.onCompleted: {
    }
}
