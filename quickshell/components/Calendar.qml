import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

PanelWindow {
  id: calendar
  visible: true
  exclusionMode: ExclusionMode.Ignore
  anchors { top: true; right: true }
  margins { top: 32; bottom: 8; right: root.calendarVisible ? 8 : -710 }
  implicitWidth: 548
  implicitHeight: 320
  focusable: false
  color: "transparent"
  WlrLayershell.keyboardFocus: root.calendarVisible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
  Behavior on margins.right { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

  property int currentMonth: new Date().getMonth()
  property int currentYear: new Date().getFullYear()

  Rectangle {
    id: mainContainer
    anchors.fill: parent
    radius: 4
    color: Qt.rgba(root.walBackground.r, root.walBackground.g, root.walBackground.b, 0.9)

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 12

      RowLayout {
        Layout.fillWidth: true
        Button {
          background: Item {}
          text: "◀"
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked:  
              if (calendar.currentMonth === 0) {
                calendar.currentMonth = 11
                calendar.currentYear--
              } else {
                calendar.currentMonth--
              }

          }
        }

        Label {
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignHCenter
          text: new Date(calendar.currentYear, calendar.currentMonth, 1).toLocaleString(Qt.locale(), "MMMM yyyy")
          color: root.walColor2
          font.family: "JetBrainsMono Nerd Font"
          font.pixelSize: 18
          font.bold: true
        }

        Button {
          text: "▶"
          background: Item {}
          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked:
              if (calendar.currentMonth === 0) {
                calendar.currentMonth = 11
                calendar.currentYear++
              } else {
                calendar.currentMonth++
              }
          }
        }
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: Qt.rgba(0, 0, 0, 0)
        radius: 4

        ColumnLayout {
          anchors.fill: parent

          DayOfWeekRow {
            Layout.fillWidth: true
            delegate: Text {
              text: model.shortName
              font.pixelSize: 14
              font.bold: true
              font.family: "JetBrainsMono Nerd Font"
              color: Qt.rgba(0, 0, 0, 1);
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
            }
          }

          MonthGrid {
            id: monthGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            month: calendar.currentMonth
            year: calendar.currentYear

            delegate: Rectangle {
              color: model.today ? Qt.rgba(0, 0, 0, 0.3) : "transparent"
              radius: 4

              Text {
                anchors.centerIn: parent
                text: model.day
                font.pixelSize: 14
                font.bold: model.today
                font.family: "JetBrainsMono Nerd Font"
                color: { 
                  if (model.month === monthGrid.month) return root.walColor2;
                  return Qt.rgba(0, 0, 0, 0.5);
                }
              }
            }
          }
        }
      }
    }
  }
}
