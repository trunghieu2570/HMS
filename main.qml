import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

ApplicationWindow  {
    title: qsTr("HMS - Hotel Management System 1.0")
    width: 1360
    height: 720
    visible: true
    id: window

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
                    _text: "Dashboard"
                    _src: "qrc:/icons/Icons/White/home_32px.png"
                }
                SidebarMenuItem {
                    _text: "Frontdesk"
                    _src: "qrc:/icons/Icons/White/booking_32px.png"
                }
                SidebarMenuItem {
                    _text: "Services"
                    _src: "qrc:/icons/Icons/White/service_32px.png"
                }
                SidebarMenuItem {
                    _text: "Reservations"
                    _src: "qrc:/icons/Icons/White/reservation_32px.png"
                }
                SidebarMenuItem {
                    _text: "Guest"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                }
                SidebarMenuItem {
                    _text: "Room Types"
                    _src: "qrc:/icons/Icons/White/customer_32px.png"
                    onClicked: {
                        stackLayout.currentIndex = 2
                        pageName.text = qsTr("Room Types")
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
                            width: 200
                            height: 60
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.pointSize: 13
                            font.bold: true
                            Label {
                                id: pageName
                                text: qsTr("Page name")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                            }
                        }
                        Button {
                            id: button
                            width: 300
                            height: 60
                            font.pointSize: 9
                            font.bold: false
                            font.family: "Arial"
                            Layout.minimumWidth: 250
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            palette {
                                //button: hovered? "blue" : "red"
                            }
                            RowLayout {
                                anchors.fill: parent
                                spacing: 0
                                Rectangle {
                                    width: 40
                                    height: 40
                                    color: "#0000ff"
                                    Layout.margins: 10
                                }
                                Label {
                                    text: qsTr("Nguyen Van Nguyen Anh")
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
                    //Page: RoomType List
                    Rectangle {
                        id: roomTypePage
                        property variant _win
                        ColumnLayout {
                            anchors.fill: parent
                            RowLayout {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Button {
                                    text: qsTr("Add New Type")
                                    onClicked: {
                                        var _com = Qt.createComponent("AddRoomTypeDialog.qml")
                                        _win = _com.createObject(roomTypePage)
                                        _win.show()
                                    }
                                }
                                Rectangle {
                                    Layout.fillWidth: true
                                }
                                TextField {
                                    height: 30
                                    selectByMouse: true
                                    placeholderText: qsTr("Find some thing...")
                                }
                                Button {
                                    Layout.maximumWidth: 60
                                    text: qsTr("GO")
                                }
                            }
                            HTableView {
                                id: roomTypeTable
                                _model: roomTypeModel
                                columnWidthProvider: function(column) {
                                    let columns = [100,200,0,0,0,0,0,roomTypeTable.width - 400]
                                    return columns[column]
                                }
                            }
                        }

                    }
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
