import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.2
import "qrc:/"
import "qrc:/dialogs"

//Page: RoomCalendarPage

Rectangle {
    id: roomCalendarPage
    property variant _win

    ListModel {
        id: monthModel
        ListElement {
            value: 1
            text: "Tháng Một"
        }
        ListElement {
            value: 2
            text: "Tháng Hai"
        }
        ListElement {
            value: 3
            text: "Tháng Ba"
        }
        ListElement {
            value: 4
            text: "Tháng Tư"
        }
        ListElement {
            value: 5
            text: "Tháng Năm"
        }
        ListElement {
            value: 6
            text: "Tháng Sáu"
        }
        ListElement {
            value: 7
            text: "Tháng Bảy"
        }
        ListElement {
            value: 8
            text: "Tháng Tám"
        }
        ListElement {
            value: 9
            text: "Tháng Chín"
        }
        ListElement {
            value: 10
            text: "Tháng Mười"
        }
        ListElement {
            value: 11
            text: "Tháng Mười Một"
        }
        ListElement {
            value: 12
            text: "Tháng Mười Hai"
        }
    }

    MessageDialog {
        id: invalidDialog
        title: "Thao tác không hợp lệ"
        onAccepted: {
        }
        icon: StandardIcon.Critical
    }



    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                text: qsTr("Đặt phòng")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/CreateReservationDialog.qml")
                    _win = _com.createObject(roomCalendarPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Làm mới")
                onClicked: {
                    roomCalendarModel.populate(selectMonthCbb.currentValue, yearTextField.text)
                    tableView.forceLayout()
                }
            }


            Rectangle {
                Layout.fillWidth: true
            }
            Button {
                text: qsTr("Hôm nay")
                onClicked: {
                    selectMonthCbb.currentIndex = selectMonthCbb.indexOfValue(1)
                    yearTextField.text = qsTr("2021")
                    roomCalendarModel.populate()
                    tableView.forceLayout()
                }
            }

            ComboBox {
                Layout.preferredWidth: 170
                id: selectMonthCbb
                model: monthModel
                textRole: "text"
                valueRole: "value"
                Component.onCompleted: {
                    currentIndex = indexOfValue(1)
                }
                onActivated: {
                    roomCalendarModel.populate(selectMonthCbb.currentValue, yearTextField.text)
                }
            }

            TextField {
                id: yearTextField
                Layout.preferredWidth: 80
                placeholderText: qsTr("Năm")
                text: qsTr("2021")
                validator: IntValidator{bottom: 2000; top: 2050;}
                onEditingFinished: {
                    roomCalendarModel.populate(selectMonthCbb.currentValue, yearTextField.text)
                    focus = false
                    tableView.focus = true
                }
            }
        }

        Rectangle {
            id: bounder
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.color: "grey"
            color: "#e0e0e0"
            border.width: 1

            ColumnLayout {

                anchors.fill: parent
                anchors.margins: 1
                spacing: 1

                TableView {
                    id: tableView
                    property int _height: 40
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    focus: true
                    columnSpacing: 1
                    rowSpacing: 1
                    clip: true
                    leftMargin: rowsHeader.implicitWidth + rowSpacing
                    topMargin: columnsHeader.implicitHeight + tableTopBar.height + 2*columnSpacing
                    columnWidthProvider: function (column) {
                        var w = tableView.model ? (tableView.width - rowsHeader.implicitWidth)/tableView.model.columnCount() : 0
                        if(w < 30)
                            return 30
                        return w
                    }
                    flickableDirection: Flickable.AutoFlickIfNeeded
                    model: roomCalendarModel
                    onWidthChanged: tableView.forceLayout()
                    boundsMovement: Flickable.StopAtBounds

                    Rectangle {
                        z: 3
                        id: tableTopBar
                        width: columnsHeader.width
                        height: 30
                        anchors.margins: 1
                        y: tableView.contentY
                        color: "white"
                        Label {
                            anchors.centerIn: parent
                            anchors.margins: 10
                            font.bold: true
                            text: selectMonthCbb.currentText + ", Năm " + yearTextField.text
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Rectangle {
                        z: 4
                        x: tableView.contentX
                        y: tableView.contentY
                        width: tableView.leftMargin - 1
                        height: tableView.topMargin - 1
                        Label {
                            anchors.fill: parent
                            anchors.margins: 10
                            text: qsTr("Phòng")
                            verticalAlignment: Text.AlignVCenter
                        }
                    }



                    Row {
                        id: columnsHeader
                        z: 3
                        y: tableView.contentY+tableTopBar.height + 1
                        spacing: 1

                        Repeater {
                            model: tableView.columns > 0 ? tableView.columns : 1
                            Rectangle {
                                id: columnsHeaderCell
                                visible: tableView.columnWidthProvider(modelData) !== 0
                                width: tableView.columnWidthProvider(modelData)
                                height: 30
                                color: "white"
                                Label {
                                    property variant dayNum: tableView.model.headerData(modelData, Qt.Horizontal)
                                    anchors.fill: parent
                                    //anchors.margins: 10
                                    text: dayNum
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        ToolTip.delay: 800
                                        ToolTip.visible: containsMouse
                                        ToolTip.text: (new Date(yearTextField.text, selectMonthCbb.currentIndex, parent.dayNum)).toLocaleDateString(Qt.locale("vi_vn"))
                                    }
                                }
                            }

                        }

                    }
                    Column {
                        id: rowsHeader
                        z: 3
                        x: tableView.contentX
                        spacing: 1
                        Repeater {
                            model: tableView.rows > 0 ? tableView.rows : 1
                            Rectangle {

                                property var current: tableView.model.headerData(modelData, Qt.Vertical)
                                //visible: tableView.rowHeightProvider(modelData) !== 0
                                width: 100
                                height: tableView._height
                                color: "white"
                                Label {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    text: roomModel.data(roomModel.index(parent.current, 1))
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }

                    delegate: Rectangle {
                        id: cell
                        implicitHeight: tableView._height
                        property var name: tableView.model.data(tableView.model.index(row, column))["name"]
                        property var m_id: tableView.model.data(tableView.model.index(row, column))["id"]
                        property var state: tableView.model.data(tableView.model.index(row, column))["state"]
                        property var check_in: tableView.model.data(tableView.model.index(row, column))["check_in"]
                        property var check_out: tableView.model.data(tableView.model.index(row, column))["check_out"]
                        color: m_id ? legendModel.get(state).mcolor : "white"
                        Text {
                            anchors.centerIn: parent
                            color: "white"
                            anchors.margins: 10
                            text: m_id ? legendModel.get(cell.state).msymbol : ""
                        }
                        MouseArea {
                            visible: m_id !== undefined
                            onClicked: {
                                var _com = Qt.createComponent("qrc:/dialogs/CreateReservationDialog.qml")
                                _win = _com.createObject(roomCalendarPage, {resId: cell.m_id, _mode: "edit"})
                                _win.show()
                            }

                            anchors.fill: parent
                            hoverEnabled: true
                            ToolTip.delay: 1000
                            ToolTip.visible: containsMouse
                            ToolTip.text: m_id > 0 ? name +
                                               "<br/>" + check_in.toLocaleDateString("YYYYMMDD") +
                                               "<br/>" + check_out.toLocaleDateString("YYYYMMDD") : "."
                        }


                    }
                    ScrollBar.horizontal: ScrollBar  {
                        policy: ScrollBar.AsNeeded
                    }
                    ScrollBar.vertical: ScrollBar  {
                        policy: ScrollBar.AsNeeded
                    }
                    //ScrollIndicator.horizontal: ScrollIndicator { }
                    // ScrollIndicator.vertical: ScrollIndicator { }
                }



                Rectangle {
                    height: 50
                    color: "white"
                    //Layout.fillHeight: true
                    Layout.fillWidth: true

                    ListModel {
                        id: legendModel
                        ListElement {
                            mcolor: "grey"
                            msymbol: "W"
                            mtext: "Chưa xác nhận"
                        }
                        ListElement {
                            mcolor: "green"
                            msymbol: "A"
                            mtext: "Đã xác nhận"
                        }
                        ListElement {
                            mcolor: "blue"
                            msymbol: "O"
                            mtext: "Đã chiếm chỗ"
                        }
                        ListElement {
                            mcolor: "red"
                            msymbol: "X"
                            mtext: "Đã hủy"
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        spacing: 0
                        Label {
                            Layout.fillHeight: true
                            Layout.margins: 10
                            width: 50
                            text: qsTr("Chú thích:")
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                        }

                        Repeater {
                            model: legendModel
                            delegate: Rectangle {
                                Layout.fillHeight: true
                                width: 200
                                RowLayout {
                                    anchors.fill: parent
                                    Rectangle {
                                        width: 30
                                        height: 30
                                        color: mcolor
                                        Label {
                                            color: "white"
                                            anchors.centerIn: parent
                                            text: msymbol
                                        }
                                    }
                                    Rectangle {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Label {
                                            anchors.fill: parent
                                            anchors.margins: 10
                                            verticalAlignment: Text.AlignVCenter
                                            text: mtext
                                        }
                                    }
                                }
                            }
                        }





                    }


                }
            }

        }

    }

}
