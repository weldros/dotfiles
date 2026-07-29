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
  anchors { top: true; bottom: true; right: true }
  margins { top: 32; bottom: 8; right: root.calendarVisible ? 8 : -450 }
  implicitWidth: 420
  //implicitHeight: 420
  focusable: true
  color: "transparent"
  WlrLayershell.keyboardFocus: root.calendarVisible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None
  Behavior on margins.right { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

  Rectangle {
    id: mainContainer
    anchors.fill: parent
    radius: 4
    color: Qt.rgba(root.walBackground.r, root.walBackground.g, root.walBackground.b, 0.7)

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 12

      Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 42
        color: Qt.rgba(0, 0, 0, 0.3)
        radius: 4
        
      }

      Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 42
        color: Qt.rgba(0, 0, 0, 0.3)
        radius: 4
        
      }
    }
  }
}
