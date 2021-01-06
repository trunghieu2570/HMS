import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import hms.dto 1.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
import "qrc:/"
import QtQuick.Dialogs 1.1

Window {
    id: root
    width: 500
    height: 350
    visible: true
    title: qsTr("Đăng nhập")
    color: "floralwhite"
    flags: Qt.Dialog

    signal login(string username, string password)

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    Image {
        id: image
        anchors.fill: parent
        z: -2
        source: "qrc:/images/Images/hotel.jpg"
        fillMode: Image.PreserveAspectCrop
    }
    FastBlur {
        anchors.fill: parent
        source: image
        radius: 32
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        ColumnLayout {
            id: col
            spacing: 15
            anchors.topMargin: 30
            anchors.leftMargin: 40
            anchors.rightMargin: 40
            anchors.bottomMargin: 40
            anchors.fill: parent
            Rectangle {
                id: rectangle
                height: 40
                color: "transparent"
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Label {
                    font.family: "Arial"
                    font.bold: true
                    font.pointSize: 15
                    color: "white"
                    text: qsTr("Hệ Thống Quản Lý Khách Sạn")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                Label {
                    color: "white"
                    text: qsTr("Tên đăng nhập:")
                    Layout.fillWidth: true
                }
                TextField {
                    id: usernameTextField
                    opacity: 0.8
                    text: qsTr("tgd")
                    selectByMouse: true
                    Layout.fillWidth: true

                }
                Label {
                    color: "white"
                    text: qsTr("Mật khẩu:")

                    Layout.fillWidth: true
                }
                TextField {
                    id: passwordTextField
                    opacity: 0.8
                    text: qsTr("tgd")
                    Layout.fillWidth: true
                    selectByMouse: true
                    echoMode: TextInput.Password
                }
            }

            RowLayout {
                width: parent.width
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 30
//                Rectangle {
//                    Layout.fillWidth: true
//                }

                Button {
                    font.bold: true
                    padding: 10
                    text: qsTr("ĐĂNG NHẬP")
                    onClicked: {
                        login(usernameTextField.text, passwordTextField.text)
                    }
                }
            }
        }
    }
    Component.onCompleted: {
    }

}


