import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4 as Old

TextField {
    id: root
    placeholderText: qsTr("Datepicker")
    onEditingFinished: {
        calendar.selectedDate = Date.fromLocaleDateString(Qt.locale(), root.text, "d/M/yyyy")
    }

    Popup {
        id: popup
        x: 0
        y: parent.height
        modal: false
        //focus: true
        visible: root.focus
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        contentItem: Old.Calendar {
            id: calendar
            onClicked: function(date) {
                root.text = date.toLocaleDateString(Qt.locale(), "d/M/yyyy")
            }
        }
        onClosed: {
            root.focus = false
        }
    }
}

