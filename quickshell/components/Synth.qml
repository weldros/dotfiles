import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

PanelWindow {
  id: synth
  visible: root.synthVisible
  exclusionMode: ExclusionMode.Ignore
  anchors { top: true}
  margins { top:31}
  implicitWidth: 420
  implicitHeight: 260
  color: "transparent"
  focusable: false

  property var cavaValues: [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,]

  Process {
    id: cavaProc
    running: synth.visible
    command: ["cava", "-p", Quickshell.env("HOME") + "/.config/cava/config_raw"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(";")
        var vals = []
        for (var i = 0; i < 12 && i < parts.length; i++) {
            var parsed = parseInt(parts[i])
            vals.push(isNaN(parsed) ? 0.1 : (parsed / 255))
        }
        while (vals.length < 12) vals.push(0.1)
        if (vals.length > 0) {
          synth.cavaValues = vals
        }
      }
    }
  }

  Rectangle {
    anchors.fill: parent
    color: Qt.rgba(root.walBackground.r, root.walBackground.g, root.walBackground.b, 0.7)
    radius: 5

    Row {
      anchors.fill: parent
      anchors.margins: 16
      spacing: 2
      Repeater {
        model: synth.cavaValues.length
        Rectangle {
          width: (parent.width - (parent.spacing * (synth.cavaValues.length - 1))) / Math.max(1, synth.cavaValues.length)
          height: Math.max(5, synth.cavaValues[index] * parent.height)
          anchors.bottom: parent.bottom
          radius: 3
          color: root.walColor5
          antialiasing: true
          Behavior on height {
            NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
          }
        }
      }
    }
  }
}
