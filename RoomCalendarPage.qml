import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "qrc:/"
import "qrc:/dialogs"

//Page: RoomCalendarPage
Rectangle {
    id: roomCalendarPage
    property variant _win



    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Button {
                text: qsTr("Add Item")
                onClicked: {
                    var _com = Qt.createComponent("qrc:/dialogs/CreateReservationDialog.qml")
                    _win = _com.createObject(roomCalendarPage)
                    _win.show()
                }
            }
            Button {
                text: qsTr("Refresh")
                onClicked: {
                    inventoryModel.populate()
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }
            TextField {
                id: searchTextField
                height: 30
                selectByMouse: true
                placeholderText: qsTr("Find something...")
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("Find")
                onClicked: {
                    inventoryModel.populate(searchTextField.text)
                }
            }
            Button {
                Layout.maximumWidth: 60
                text: qsTr("Reset")
                onClicked: {
                    searchTextField.text = qsTr("")
                    inventoryModel.populate(searchTextField.text)
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            border.color: "grey"
            color: "gray"
            border.width: 1
            TableView {
                id: tableView
                property int _height: 40
                focus: true
                columnSpacing: 1
                rowSpacing: 1
                anchors.fill: parent
                anchors.margins: parent.border.width
                clip: true
                leftMargin: rowsHeader.implicitWidth + rowSpacing
                topMargin: columnsHeader.implicitHeight + columnSpacing
                columnWidthProvider: function (column) {
                    var w = tableView.model ? (tableView.width - rowsHeader.implicitWidth)/tableView.model.columnCount() : 0
                    if(w < 30)
                        return 30
                    return w
                }
                flickableDirection: Flickable.AutoFlickIfNeeded
                model: roomCalendarModel
                onWidthChanged: tableView.forceLayout()

                Row {
                    id: columnsHeader
                    z: 3
                    y: tableView.contentY
                    spacing: 1
                    Repeater {
                        model: tableView.columns > 0 ? tableView.columns : 1
                        Rectangle {
                            visible: tableView.columnWidthProvider(modelData) !== 0
                            width: tableView.columnWidthProvider(modelData)
                            height: 40
                            color: "white"
                            Label {
                                anchors.fill: parent
                                anchors.margins: 10
                                text: tableView.model.headerData(modelData, Qt.Horizontal)
                                verticalAlignment: Text.AlignVCenter
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
                        Button {
                            property var current: tableView.model.headerData(modelData, Qt.Vertical)
                            //visible: tableView.rowHeightProvider(modelData) !== 0
                            width: 100
                            //height: tableView.rowHeightProvider(modelData)
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
                    property var id: tableView.model.data(tableView.model.index(row, column))["id"]
                    color: name ? "blue": "white"
                    Text {
                        anchors.fill: parent
                        anchors.margins: 10
                        text: name ? name : ""
                        property bool hovered: false
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

        }

    }

}
