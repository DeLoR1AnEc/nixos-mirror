import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick

PanelWindow {
  id: root
  required property var modelData
  screen: modelData

  anchors { top: true; left: true; right: true }
  implicitHeight: 30
  color: "#100f0f" // bg

  // ---- niri workspaces (no native binding — poll `niri msg -j workspaces`) ----
  property var workspaceModel: []

  Process {
    id: wsProc
    command: ["niri", "msg", "-j", "workspaces"]
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          root.workspaceModel = JSON.parse(text);
        } catch (e) {
          console.warn("niri workspaces: bad json", e);
        }
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: wsProc.running = true
  }

  // ---- pipewire default sink ----
  PwObjectTracker { objects: [Pipewire.defaultAudioSink] }

  // ---- upower display battery ----
  property var battery: UPower.displayDevice

  Item {
    anchors.fill: parent
    anchors.leftMargin: 12
    anchors.rightMargin: 12

    // left: workspaces
    Row {
      id: workspaces
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      spacing: 14

      Repeater {
        model: root.workspaceModel.filter(w => w.output === root.screen.name)

        delegate: Item {
          required property var modelData
          width: 16
          height: parent.height

          Text {
            anchors.centerIn: parent
            text: modelData.idx
            font.family: "Maple Mono NF"
            font.pixelSize: 12
            color: modelData.is_focused ? "#d0a441" : "#575653" // amber / tx-2
          }

          Rectangle {
            visible: modelData.is_focused
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 14
            height: 2
            color: "#d0a441" // amber
          }
        }
      }
    }

    // center: clock
    SystemClock {
      id: clock
      precision: SystemClock.Seconds
    }

    Text {
      anchors.centerIn: parent
      text: Qt.formatDateTime(clock.date, "HH:mm:ss")
      font.family: "Maple Mono NF"
      font.pixelSize: 13
      color: "#cecdc3" // tx
    }

    // right: volume, battery
    Row {
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      spacing: 16

      Text {
        font.family: "Maple Mono NF"
        font.pixelSize: 12
        color: "#617753" // sage — level readout
        text: {
          const sink = Pipewire.defaultAudioSink;
          if (!sink || !sink.audio) return "VOL --";
          if (sink.audio.muted) return "VOL MUTE";
          return "VOL " + Math.round(sink.audio.volume * 100) + "%";
        }
      }

      Text {
        font.family: "Maple Mono NF"
        font.pixelSize: 12
        color: {
          if (!root.battery || !root.battery.ready) return "#575653"; // tx-2
          const low = root.battery.percentage < 0.2 && root.battery.state === UPowerDeviceState.Discharging;
          return low ? "#8b5343" : "#575653"; // rust / tx-2
        }
        text: {
          if (!root.battery || !root.battery.ready) return "BAT --";
          return "BAT " + Math.round(root.battery.percentage * 100) + "%";
        }
      }
    }
  }

  // bottom hairline
  Rectangle {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 1
    color: "#343331" // ui
  }
}
