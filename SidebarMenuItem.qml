import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Button {
    id: button
    property string _text: "text"
    property string _src: "qrc:/icons/Icons/White/customer_32px.png"
    property int _pageId: 0

    palette {
        button: hovered? "blue" : "transparent"
    }

    hoverEnabled: true
    width: parent.width
    height: 60
    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.leftMargin: 20
        spacing: 10
        Image {
            id: name
            source: _src
            sourceSize.height: 30
            sourceSize.width: 30
        }
        Label {
            Layout.fillWidth: true
            color: "white"
            font.bold: true
            font.pointSize: 12
            font.family: "Arial"
            text: qsTr(_text)
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
