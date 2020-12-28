import QtQuick.Controls 2.5
import QtQuick 2.15
import QtQuick.Layouts 1.3

TableView {
    id: tableView
    //properties
    required property variant _model
    property int _height: 40
    signal editButtonClicked(int index)
    signal deleteButtonClicked(int index)


    focus: true
    Layout.fillHeight: true
    Layout.fillWidth: true
    //columnSpacing: 1
    //property int selected: 1
    rowSpacing: 1
    clip: true
    topMargin: columnsHeader.implicitHeight
    columnWidthProvider: function (column) {
        return tableView.model ? (tableView.width-actionHeader.width)/tableView.model.columnCount() : 0
    }
    flickableDirection: Flickable.AutoFlickIfNeeded
    model: _model
    onWidthChanged: tableView.forceLayout()
    //handle keypress
    /*
    Keys.onUpPressed: {
        if (tableView.selected > 0)
            tableView.selected--
        tableView.contentY = tableView.delegate.implicitHeight * tableView.selected
        tableView.forceLayout()
    }
    Keys.onDownPressed: {
        if (tableView.selected < tableView.rows - 1)
            tableView.selected++
        tableView.contentY = tableView.delegate.implicitHeight * tableView.selected
        tableView.forceLayout()
    }
    */
    Rectangle {
        anchors.fill: parent
        color: "#ebedf2"
    }
    Row {
        id: columnsHeader
        z: 3
        y: tableView.contentY
        Repeater {
            model: tableView.columns > 0 ? tableView.columns : 1
            Button { 
                visible: tableView.columnWidthProvider(modelData) !== 0
                width: tableView.columnWidthProvider(modelData)
                height: 40
                Label {
                    anchors.fill: parent
                    anchors.margins: 10
                    text: _model.headerData(modelData, Qt.Horizontal)
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        Button {
            id: actionHeader
            width: 100
            height: 40
            Label {
                anchors.fill: parent
                anchors.margins: 10
                text: qsTr("Hành động")
                verticalAlignment: Text.AlignVCenter
            }
        }

    }

    Rectangle {
        color: "#ebedf2"
        x: tableView.width-actionHeader.width
        width: actionHeader.width
        height: tableView.contentHeight
    }

    Column {
        id: rowActions
        z: 2
        x: tableView.width-actionHeader.width
        spacing: 1
        Repeater {
            id: repeater
            model: tableView.rows > 0 ? tableView.rows : 0
            Rectangle {
                width: actionHeader.width
                height: tableView._height
                color: modelData % 2 != 0 ? "mintcream" : "white"
                Row {
                    anchors.fill: parent
                    Button {
                        //anchors.fill: parent
                        //anchors.margins: 10
                        anchors.verticalCenter: parent.verticalCenter
                        palette {
                            button: "transparent"
                        }
                        icon.source: "qrc:/icons/Icons/Black/edit_32px.png"
                        display: "IconOnly"
                        text: qsTr("Edit")
                        width: 32; height: 32
                        onClicked: {
                            editButtonClicked(modelData)
                        }
                    }
                    Button {
                        //anchors.fill: parent
                        //anchors.margins: 10
                        anchors.verticalCenter: parent.verticalCenter
                        palette {
                            button: "transparent"
                        }
                        icon.source: "qrc:/icons/Icons/Black/trash_32px.png"
                        display: "IconOnly"
                        text: qsTr("Remove")
                        width: 32; height: 32
                        onClicked: {
                            deleteButtonClicked(modelData)
                        }
                    }
                }
            }
        }
    }
    delegate: Rectangle {
        id: cell
        implicitHeight: tableView._height
        color: row % 2 != 0 ? "mintcream" : "white"
        /*
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(row)
                //tableView.selected = row
                tableView.forceLayout()
                tableView.focus = true
            }

        }
        */
        Text {
            anchors.fill: parent
            anchors.margins: 10
            text: _model.data(_model.index(row, column))
            property bool hovered: false
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                ToolTip.delay: 1000
                ToolTip.visible: containsMouse
                ToolTip.text: _model.data(_model.index(row, column))
            }
        }
    }
    ScrollBar.vertical: ScrollBar {}
    //ScrollIndicator.horizontal: ScrollIndicator { }
   // ScrollIndicator.vertical: ScrollIndicator { }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
