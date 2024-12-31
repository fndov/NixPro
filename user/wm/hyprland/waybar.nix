{ pkgs, userSettings, ... }: {
  home.packages = [ pkgs.waybar pkgs.nerdfonts ];
  wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "7 7 3 7";
        spacing = 2;

        modules-left = [
          "group/power"
          "group/battery"
          "group/backlight"
          "group/cpu"
          "group/memory"
          "group/pulseaudio"
          "keyboard-state"
        ];
        modules-center = [ "custom/hyprprofile" "hyprland/workspaces" ];
        modules-right = [ "group/time" "idle_inhibitor" "tray" ];

        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo "" '';
          "interval" = "once";
          "on-click" = "${userSettings.terminal}";
          "tooltip" = false;
        };
        "group/power" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "children-class" = "not-power";
            "transition-left-to-right" = true;
          };
          "modules" = [
            "custom/os"
            "custom/hyprprofileicon"
            "custom/lock"
            "custom/quit"
            "custom/power"
            "custom/reboot"
          ];
        };
        "custom/quit" = {
          "format" = "󰍃";
          "tooltip" = false;
          "on-click" = "hyprctl dispatch exit";
        };
        "custom/lock" = {
          "format" = "󰍁";
          "tooltip" = false;
          "on-click" = "hyprlock";
        };
        "custom/reboot" = {
          "format" = "󰜉";
          "tooltip" = false;
          "on-click" = "reboot";
        };
        "custom/power" = {
          "format" = "󰐥";
          "tooltip" = false;
          "on-click" = "shutdown now";
        };
        "custom/hyprprofileicon" = {
          "format" = "󱙋";
          "on-click" = "alacritty -e sh -c btm";
          "tooltip" = false;
        };
        "custom/hyprprofile" = {
          "format" = " {}";
          "exec" = "cat ~/.hyprprofile";
          "interval" = 3;
          "on-click" = "alacritty -e sh -c btm";
        };
        "keyboard-state" = {
          "numlock" = true;
          "format" = "{icon}";
          "format-icons" = {
            "locked" = "󰎠 ";
            "unlocked" = "󱧓 ";
          };
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "I";
            "2" = "II";
            "3" = "III";
            "4" = "IV";
            "5" = "V";
            "6" = "VI";
            "7" = "VII";
            "8" = "VIII";
            "9" = "IX";
            "scratch_term" = "_";
            "scratch_ranger" = "_󰴉";
            "scratch_music" = "_";
            "scratch_btm" = "_";
            "scratch_pavucontrol" = "_󰍰";
          };
          "on-click" = "activate";
          "on-scroll-up" = "hyprnome";
          "on-scroll-down" = "hyprnome --previous";
          "all-outputs" = false;
          "active-only" = false;
          "ignore-workspaces" = [ "scratch" "-" ];
          "show-special" = false;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
        tray = {
          #"icon-size" = 21;
          "spacing" = 10;
        };
        "clock#time" = {
          "interval" = 1;
          "format" = "{:%I:%M:%S %p}";
          "timezone" = "America/Chicago";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "clock#date" = {
          "interval" = 1;
          "format" = "{:%a %Y-%m-%d}";
          "timezone" = "America/Chicago";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "group/time" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = false;
          };
          "modules" = [ "clock#time" "clock#date" ];
        };

        cpu = { "format" = "󰍛"; };
        "cpu#text" = { "format" = "{usage}%"; };
        "group/cpu" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "cpu" "cpu#text" ];
        };

        memory = { "format" = ""; };
        "memory#text" = { "format" = "{}%"; };
        "group/memory" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "memory" "memory#text" ];
        };

        backlight = {
          "format" = "{icon}";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        };
        "backlight#text" = { "format" = "{percent}%"; };
        "group/backlight" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "backlight" "backlight#text" ];
        };

        battery = {
          "states" = {
            "good" = 75;
            "warning" = 30;
            "critical" = 15;
          };
          "fullat" = 80;
          "format" = "{icon}";
          "format-charging" = "󰂄";
          "format-plugged" = "󰂄";
          "format-full" = "󰁹";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "interval" = 10;
        };
        "battery#text" = {
          "states" = {
            "good" = 75;
            "warning" = 30;
            "critical" = 15;
          };
          "fullat" = 80;
          "format" = "{capacity}%";
        };
        "group/battery" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "battery" "battery#text" ];
        };
        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{icon}";
          "format-bluetooth" = "{icon}";
          "format-bluetooth-muted" = "󰸈";
          "format-muted" = "󰸈";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" =
            "hyprctl dispatch togglespecialworkspace scratch_pavucontrol; if hyprctl clients | grep pavucontrol; then echo 'scratch_ranger respawn not needed'; else pavucontrol; fi";
        };
        "pulseaudio#text" = {
          "scroll-step" = 1;
          "format" = "{volume}%";
          "format-bluetooth" = "{volume}%";
          "format-bluetooth-muted" = "";
          "format-muted" = "";
          "format-source" = "{volume}%";
          "format-source-muted" = "";
          "on-click" =
            "hyprctl dispatch togglespecialworkspace scratch_pavucontrol; if hyprctl clients | grep pavucontrol; then echo 'scratch_ranger respawn not needed'; else pavucontrol; fi";
        };
        "group/pulseaudio" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 500;
            "transition-left-to-right" = true;
          };
          "modules" = [ "pulseaudio" "pulseaudio#text" ];
        };
      };
    };
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, '' + userSettings.font + ''
        ;

                  font-size: 20px;
              }

              window#waybar {
                  background-color: rgba(30, 30, 46, 0.55);
                  border-radius: 8px;
                  color: #cdd6f4;
                  transition-property: background-color;
                  transition-duration: .2s;
              }

              tooltip {
                color: #cdd6f4;
                background-color: rgba(30, 30, 46, 0.9);
                border-style: solid;
                border-width: 3px;
                border-radius: 8px;
                border-color: #f38ba8;
              }

              tooltip * {
                color: #cdd6f4;
                background-color: rgba(30, 30, 46, 0.0);
              }

              window > box {
                  border-radius: 8px;
                  opacity: 0.94;
              }

              window#waybar.hidden {
                  opacity: 0.2;
              }

              button {
                  border: none;
              }

              #custom-hyprprofile {
                  color: #cdd6f4;
              }

              /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
              button:hover {
                  background: inherit;
              }

              #workspaces button {
                  padding: 0px 6px;
                  background-color: transparent;
                  color: #cdd6f4;
                  font-weight: bold;
              }

              #workspaces button:hover {
                  color: #cdd6f4;
              }

              #workspaces button.active {
                  color: #cdd6f4;
              }

              #workspaces button.focused {
                  color: #cdd6f4;
              }

              #workspaces button.visible {
                  color: #cdd6f4;
              }

              #workspaces button.urgent {
                  color: #cdd6f4;
              }

              #battery,
              #cpu,
              #memory,
              #disk,
              #temperature,
              #backlight,
              #network,
              #pulseaudio,
              #wireplumber,
              #custom-media,
              #tray,
              #mode,
              #idle_inhibitor,
              #scratchpad,
              #custom-hyprprofileicon,
              #custom-quit,
              #custom-lock,
              #custom-reboot,
              #custom-power,
              #mpd {
                  padding: 0 3px;
                  color: #cdd6f4;
                  border: none;
                  border-radius: 8px;
              }

              #custom-hyprprofileicon,
              #custom-quit,
              #custom-lock,
              #custom-reboot,
              #custom-power,
              #idle_inhibitor {
                  background-color: transparent;
                  color: #cdd6f4;
              }

              #custom-hyprprofileicon:hover,
              #custom-quit:hover,
              #custom-lock:hover,
              #custom-reboot:hover,
              #custom-power:hover,
              #idle_inhibitor:hover {
                  color: #cdd6f4;
              }

              #clock, #tray, #idle_inhibitor {
                  padding: 0 5px;
              }

              #window,
              #workspaces {
                  margin: 0 6px;
              }

              /* If workspaces is the leftmost module, omit left margin */
              .modules-left > widget:first-child > #workspaces {
                  margin-left: 0;
              }

              /* If workspaces is the rightmost module, omit right margin */
              .modules-right > widget:last-child > #workspaces {
                  margin-right: 0;
              }

              #clock {
                  color: #cdd6f4;
              }

              #battery {
                  color: #cdd6f4;
              }

              #battery.charging, #battery.plugged {
                  color: #cdd6f4;
              }

              @keyframes blink {
                  to {
                      background-color: #cdd6f4;
                      color: #1e1e2e;
                  }
              }

              #battery.critical:not(.charging) {
                  background-color: #cdd6f4;
                  color: #1e1e2e;
                  animation-name: blink;
                  animation-duration: 0.5s;
                  animation-timing-function: linear;
                  animation-iteration-count: infinite;
                  animation-direction: alternate;
              }

              label:focus {
                  background-color: #1e1e2e;
              }

              #cpu {
                  color: #cdd6f4;
              }

              #memory {
                  color: #cdd6f4;
              }

              #disk {
                  color: #cdd6f4;
              }

              #backlight {
                  color: #cdd6f4;
              }

              label.numlock {
                  color: #cdd6f4;
              }

              label.numlock.locked {
                  color: #cdd6f4;
              }

              #pulseaudio {
                  color: #cdd6f4;
              }

              #pulseaudio.muted {
                  color: #cdd6f4;
              }

              #tray > .passive {
                  -gtk-icon-effect: dim;
              }

              #tray > .needs-attention {
                  -gtk-icon-effect: highlight;
              }

              #idle_inhibitor {
                  color: #cdd6f4;
              }

              #idle_inhibitor.activated {
                  color: #cdd6f4;
              }
      '';
  };
}
