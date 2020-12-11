import QtQuick.Controls 2.5
import QtQuick 2.15
import QtQuick.Layouts 1.3

TableView {
    id: tableView
    //properties
    required property variant _model

    focus: true
    Layout.fillHeight: true
    Layout.fillWidth: true
    //columnSpacing: 1
    property int selected: 1
    //rowSpacing: 1
    clip: true
    topMargin: columnsHeader.implicitHeight
    columnWidthProvider: function (column) {
        return tableView.model ? tableView.width/tableView.model.columnCount() : 0
    }
    flickableDirection: Flickable.AutoFlickIfNeeded
    model: _model
    onWidthChanged: tableView.forceLayout()
    //handle keypress
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
    Row {
        id: columnsHeader
        z: 2
        y: tableView.contentY
        Repeater {
            model: tableView.columns > 0 ? tableView.columns : 1
            Button {
                width: tableView.columnWidthProvider(modelData)
                height: 40
                text: _model.headerData(modelData, Qt.Horizontal)
            }
        }
    }

    delegate: Rectangle {
        id: cell
        border.width: 1
        implicitHeight: 40
        color: tableView.selected === row ? "lightblue" : "transparent"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(row)
                tableView.selected = row
                tableView.forceLayout()
                tableView.focus = true
            }

        }
        Text {
            anchors.fill: parent
            anchors.margins: 10
            text: display
        }
    }
    ScrollBar.vertical: ScrollBar {}
    //ScrollIndicator.horizontal: ScrollIndicator { }
   // ScrollIndicator.vertical: ScrollIndicator { }
}
