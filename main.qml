import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1
import "qrc:/pages"
import "qrc:/dialogs"

ApplicationWindow  {
    title: qsTr("HMS - Hotel Management System 1.0")
    width: 1360
    height: 720
    visible: true
    id: window

    MessageDialog {
        id: loginFailDialog

        title: "Đăng nhập"
        text: "Tài khoản đăng nhập hoặc mật khẩu không chính xác!"
        onAccepted: {
        }
        icon: StandardIcon.Critical
    }

    MessageDialog {
        id: confirmLogoutDialog
        width: 300
        title: "Đăng xuất"
        text: "Bạn thật sự muốn đăng xuất?"
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            authenticationService.logout()
        }

        icon: StandardIcon.Critical
    }

    Connections {
        target: authenticationService
        onLoggedOut: {
            console.log("real logged out")
            loginDialog.show()
        }
    }

    LoginDialog {
        id: loginDialog
        visible: true
        onLogin: function(username, password) {
            if(authenticationService.login(username, password) <= 0) {
                loginFailDialog.visible = true
            } else {
                accountFullNameLabel.text = authenticationService.currentUserName
                accountAvatarImage.source = "image://avatar/" + authenticationService.currentUserId
                close()
                window.show()
            }

        }

        onActiveChanged: {
            if (active)
                window.hide()
        }
    }

    SplitView {
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        orientation: Qt.Horizontal

        Rectangle {
            implicitWidth: 300
            SplitView.maximumWidth: 400
            color: "slategrey"
            Rectangle {
                id: logo
                anchors.top: parent
                color: "midnightblue"
                height: 60
                width: parent.width
                Label {
                    color: "white"
                    anchors.centerIn: parent
                    text: qsTr("LOGO")
                    font.bold: true
                    font.pointSize: 14
                    font.family: "Tahoma"
                }
            }
            Column {
                anchors.top: logo.bottom
                anchors.topMargin: 30
                width: parent.width
                SidebarMenuItem {
                    _text: "Bảng điều khiển"
                    _src: "qrc:/icons/Icons/White/home_32px.png"
                }
                SidebarMenuItem {
                    _text: "Đặt phòng nhanh"
                    _src: "qrc:/icons/Icons/White/booking_32px.png"
                }
                SidebarMenuItem {
                    _text: "Các dịch vụ"
                    _src: "qrc:/icons/Icons/White/service_32px.png"
                }
                SidebarMenuItem {
                    _text: "Lịch phòng"
                    _src: "qrc:/icons/Icons/White/reservation_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 8
                        pageName.text = qsTr("Lịch phòng")
                    }
                }
                SidebarMenuItem {
                    _text: "Khách hàng"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 4
                        pageName.text = qsTr("Khách hàng")
                    }
                }
                SidebarMenuItem {
                    _text: "Loại phòng"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 2
                        pageName.text = qsTr("Các loại phòng")
                    }
                }
                SidebarMenuItem {
                    _text: "Đồ dùng"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 3
                        pageName.text = qsTr("Danh sách đồ dùng")
                    }
                }
                SidebarMenuItem {
                    _text: "Phòng"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 5
                        pageName.text = qsTr("Danh sách phòng")
                    }
                }
                SidebarMenuItem {
                    _text: "Loại dịch vụ"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 6
                        pageName.text = qsTr("Danh sách loại dịch vụ")
                    }
                }
                SidebarMenuItem {
                    _text: "Tài khoản"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 7
                        pageName.text = qsTr("Quản lý tài khoản nhân viên")
                    }
                }
            }
        }
        Rectangle {
            id: centerItem
            SplitView.minimumWidth: 50
            SplitView.fillWidth: true
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                ToolBar {
                    Layout.fillWidth: true
                    height: 60
                    Layout.minimumHeight: 60
                    Layout.fillHeight: false
                    RowLayout{
                        id: row2
                        height: parent.height
                        width: parent.width
                        Button {
                            id: button1
                            //                            width: 200
                            //                            height: 60
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.pointSize: 13
                            font.bold: true
                            Label {
                                id: pageName
                                text: qsTr("Hệ thống quản lý khách sạn")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                            }
                        }
                        Button {
                            id: userMenuButton
                            font.pointSize: 9
                            font.bold: false
                            font.family: "Arial"
                            Layout.minimumWidth: accountFullNameLabel.contentWidth + 80
                            Layout.fillHeight: true
                            palette {
                                //button: hovered? "blue" : "red"
                            }
                            onClicked: contextMenu.open()
                            Menu {
                                id: contextMenu
                                y: parent.height
                                MenuItem { text: "Chỉnh sửa thông tin" }
                                MenuItem { text: "Đổi mật khẩu" }
                                MenuItem {
                                    text: "Đăng xuất"
                                    onTriggered: {
                                        confirmLogoutDialog.visible = true
                                    }
                                }
                            }
                            RowLayout {
                                id: userMenuButtonLayout
                                anchors.fill: parent
                                spacing: 0
                                Rectangle {
                                    width: 40
                                    height: 40
                                    color: "#0000ff"
                                    border.color: "black"
                                    border.width: 1
                                    Layout.margins: 10
                                    Image {
                                        anchors.fill: parent
                                        id: accountAvatarImage
                                    }
                                }
                                Label {
                                    id: accountFullNameLabel
                                    text: qsTr("Người dùng khách")
                                    Layout.leftMargin: 0
                                    Layout.margins: 10
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }
                }
                StackLayout {
                    id: stackLayout
                    currentIndex: 1
                    Layout.margins: 40
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    //Page1
                    Rectangle {
                        Layout.margins: 40
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        ColumnLayout {
                            anchors.fill: parent
                            RowLayout {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                ComboBox {
                                    height: 30
                                    width: 200
                                    //selectByMouse: true
                                    //placeholderText: qsTr("Search")
                                }
                                TextField {
                                    height: 30
                                    Layout.maximumWidth: 100
                                    selectByMouse: true
                                    placeholderText: qsTr("Year")
                                    text: qsTr("2020")
                                }
                                Button {
                                    Layout.maximumWidth: 50
                                    text: qsTr("GO")
                                }
                                Rectangle {
                                    Layout.fillWidth: true
                                }
                                TextField {
                                    height: 30
                                    selectByMouse: true
                                    placeholderText: qsTr("Search")
                                }
                                Button {
                                    Layout.maximumWidth: 60
                                    text: qsTr("Search")
                                }
                            }
                            TableView {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                columnSpacing: 1
                                rowSpacing: 1
                                clip: true
                                topMargin: columnsHeader.implicitHeight
                                model: myModel
                                delegate: Rectangle {
                                    implicitWidth: 100
                                    implicitHeight: 50
                                    Text {
                                        text: display
                                    }
                                }

                                Row {
                                    id: columnsHeader
                                    Repeater {
                                        model: 3
                                        Rectangle {
                                            width: 100; height: 40
                                            border.width: 1
                                            color: "yellow"
                                        }
                                    }
                                }
                                ScrollIndicator.horizontal: ScrollIndicator { }
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }
                        }
                    }

                    Rectangle {
                        id: r1
                        ColumnLayout {
                            anchors.fill: parent
                            RowLayout {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                ComboBox {
                                    height: 30
                                    width: 200
                                    //selectByMouse: true
                                    //placeholderText: qsTr("Search")
                                }
                                TextField {
                                    height: 30
                                    Layout.maximumWidth: 100
                                    selectByMouse: true
                                    placeholderText: qsTr("Year")
                                    text: qsTr("2020")
                                }
                                Button {
                                    Layout.maximumWidth: 50
                                    text: qsTr("GO")
                                }
                                Rectangle {
                                    Layout.fillWidth: true
                                }
                                TextField {
                                    height: 30
                                    selectByMouse: true
                                    placeholderText: qsTr("Search")
                                }
                                Button {
                                    Layout.maximumWidth: 60
                                    text: qsTr("Search")
                                }
                            }
                            HTableView {
                                id: clientTable
                                _model: clientModel
                            }
                        }
                    }
                    RoomTypeListPage {

                    }


                    InventoryListPage {

                    }

                    ClientListPage {

                    }

                    RoomListPage {

                    }

                    ServiceTypeListPage {}

                    UserAccountListPage {}

                    RoomCalendarPage {}

                }


            }

        }


        // ...
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:22}
}
##^##*/
