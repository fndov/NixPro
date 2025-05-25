{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      waybar
      networkmanagerapplet
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "nice -1 waybar"
    ];
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER,W,exec,pgrep waybar > /dev/null && pkill waybar || nice -1 waybar &"
    ];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          margin = "2 0 0 0";
          spacing = 0;

          modules-left = [
            "group/power"
            "backlight#combined"
            "cpu#combined"
            "memory#combined"
            "zram#combined"
            "vram#combined"
            "pulseaudio#combined"
            "custom/data-usage"
            "keyboard-state"
          ];
          modules-center = [
            "custom/workspacesfix"
            "hyprland/workspaces"
          ];
          "hyprland/workspaces" = {
            "format" = "{name}";
            "on-click" = "activate";
            "on-scroll-up" = "hyprnome";
            "on-scroll-down" = "hyprnome --previous";
            "all-outputs" = false;
            "active-only" = false;
            "ignore-workspaces" = [ "scratch" "-" ];
            "show-special" = false;
            "fixed-width" = true;
            "sort-by-number" = true;
          };
          modules-right = [ "custom/empty" "hyprland/window" "group/time" "idle_inhibitor" "tray" ];

          "custom/menu" = {
            "format" = " MENU ";
            "exec" = ''echo "MENU" '';
            "interval" = "once";
            "on-click" = "nice -21 rofi -show drun";
            "tooltip" = false;
          };

          "custom/power-profile" = {
            "format" = "CLOCK {}";
            "exec" = "powerprofilesctl get | tr '[:lower:]' '[:upper:]'";
            "interval" = 1;
            "on-click" = "(powerprofilesctl get | grep performance > /dev/null && powerprofilesctl set balanced) || (powerprofilesctl get | grep balanced > /dev/null && powerprofilesctl set power-saver) || powerprofilesctl set performance";
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
              "custom/menu"
              "custom/power-profile"
              "custom/lock"
              "custom/quit"
              "custom/power"
              "custom/reboot"
            ];
          };

          "custom/quit" = {
            "format" = "HIBERNATE";
            "tooltip" = false;
            "on-click" = "systemctl hibernate";
          };

          "custom/lock" = {
            "format" = "LOCK";
            "tooltip" = false;
            "on-click" = "hyprlock & sleep 4 && systemctl suspend";
          };

          "custom/reboot" = {
            "format" = "REBOOT";
            "tooltip" = false;
            "on-click" = "reboot";
          };

          "custom/power" = {
            "format" = "POWER";
            "tooltip" = false;
            "on-click" = "shutdown now";
          };

          "custom/hyprprofile" = {
            "format" = "PROFILE: {}";
            "exec" = "cat ~/.hyprprofile";
            "interval" = 3;
            "on-click" = "alacritty -e sh -c btm";
          };

          "keyboard-state" = {
            "numlock" = true;
            "format" = "{name}";
            "format-icons" = {
              "locked" = "NUM ON";
              "unlocked" = "NUM OFF";
            };
          };

          "custom/workspacesfix" = {
            "format" = "         ";
            "tooltip" = false;
          };

          "custom/empty" = {
            "format" = "         ";
            "tooltip" = false;
          };

          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "BUSY";
              deactivated = "IDLE";
            };
          };
          tray = {
            "icon-size" = 15;
            "spacing" = 10;
          };

          "clock#time" = {
            "interval" = 60;
            "format" = "{:%A %B %m/%d %I:%M %p}";
            "timezone" = "America/Chicago";
            "tooltip-format" = "{calendar}";
            "calendar" = {
              "mode" = "month";
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'>{}</span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };
          "group/time" = {
            "orientation" = "horizontal";
            "modules" = [ "clock#time" ];
          };

          "hyprland/window" = {
            "format" = "{}";
            "separate-outputs" = true;
          };

          "cpu#combined" = {
            "format" = "CPU {usage}%";
            "tooltip" = false;
          };

          "memory#combined" = {
            "format" = "RAM {}%";
            "tooltip-format" = "{used:0.1f}G / {total:0.1f}G used";
          };

          "backlight#combined" = {
            "format" = "LIGHT {percent}%";
            "tooltip" = false;
          };
          "group/backlight" = {
            "orientation" = "horizontal";
            "modules" = [ "backlight#combined" ];
          };

          "pulseaudio#combined" = {
            "scroll-step" = 1;
            "format" = "SOUND {volume}%";
            "format-bluetooth" = "BT {volume}%";
            "format-bluetooth-muted" = "BT MUTE";
            "format-muted" = "MUTE";
            "on-click" = "playerctl play-pause";
            "tooltip" = false;
          };

          "custom/data-usage" = {
            format = "{}";
            exec = ''
              awk 'NR>2 { rx += $2 } \
                   END {
                     n = int(rx/1024/1024/1024);
                     if (n >= 1) printf("%dG", n);
                   }' /proc/net/dev
            '';
            interval = 10;
            tooltip = false;
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "Inter", FontAwesome, Noto;
          font-size: 14px;
          font-weight: bold;
          min-height: 0px;
        }

        window#waybar {
          background-color: rgba(30, 30, 46, 0.55);
          color: #c0caf5;
          padding: 6px 0 0 0;
          border-radius: 8px;
          transition-property: background-color;
          transition-duration: .2s;
        }

        #workspaces {
          padding-left: 20px;
          margin-left: 450px;
        }

        #window {
          margin-left: 650px;
        }

        tooltip {
          color: #cdd6f4;
          background-color: rgba(30, 30, 46, 0.9);
          border-style: solid;
          border-width: 3px;
          border-radius: 8px;
          border-color: #3b3c47;
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

        button:hover {
          background: inherit;
        }

        #workspaces button {
          padding: 0px 6px;
          background-color: transparent;
          color: #c0caf5;
          font-weight: bold;
          min-width: 20px;
          font-size: 16px;
        }

        #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inherit;
          text-shadow: inherit;
          color: #ffffff;
        }

        #workspaces button.active {
          background-color: rgba(0, 0, 0, 0.2);
          color: #c6d0f5;
          box-shadow: inset 0 -3px #8caaee;
          font-weight: 900;
        }

        #workspaces button.focused {
          background-color: rgba(0, 0, 0, 0.2);
          color: #c6d0f5;
          box-shadow: inset 0 -3px #8caaee;
          font-weight: 900;
        }

        #workspaces button.visible {
          color: #c0caf5;
        }

        #workspaces button.urgent {
          background-color: #ff9e64;
          color: #c0caf5;
        }


        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #pulseaudio#combined,
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
        #custom-menu,
        #custom-power-profile,
        #custom-data-usage,
        #mpd {
          padding: 0 3px;
          color: #c0caf5;
          border: none;
          border-radius: 8px;
        }

        #custom-menu {
          background-color: transparent;
          color: #c0caf5;
          min-width: 60px;
          padding: 0 3px;
          margin: 0 3px 0 0;
        }
        #custom-power-profile {
          background-color: transparent;
          color: #c0caf5;
          min-width: 120px;
          padding: 0 3px;
          margin: 0;
        }

        #custom-data-usage {
          background-color: transparent;
          color: #c0caf5;
          padding: 0 3px;
          margin: 0;
        }

        #custom-hyprprofileicon:hover,
        #custom-quit:hover,
        #custom-lock:hover,
        #custom-reboot:hover,
        #custom-power:hover,
        #custom-menu:hover,
        #custom-power-profile:hover,
        #pulseaudio:hover,
        #pulseaudio#combined:hover {
          background: rgba(0, 0, 0, 0.2);
          color: #ffffff;
        }

        #idle_inhibitor:hover,
        #idle_inhibitor.activated:hover {
          background: rgba(0, 0, 0, 0.2);
          color: #ffffff;
        }

        .not-power {
          margin-right: 3px;
        }

        #taskbar button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inset 0 3px #ffffff;
        }

        #taskbar button.active {
          background-color: #64727D;
          box-shadow: inset 0 3px #ffffff;
        }

        #clock,
        #cpu,
        #custom-poweroff,
        #custom-weather,
        #disk,
        #idle_inhibitor,
        #memory,
        #mode,
        #network.vpn,
        #network.wifi,
        #network.ethernet,
        #network.disconnected,
        #pulseaudio,
        #taskbar,
        #tray {
          padding-left: 6px;
          color: #c0caf5;
        }

        #window,
        #workspaces {
          margin: 0 6px;
        }

        .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
        }

        .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
        }

        #clock {
          color: #cdd6f4;
        }



        label:focus {
          background-color: #15161e;
        }

        #cpu {
          color: #c0caf5;
        }

        #memory {
          color: #c0caf5;
        }

        #disk {
          color: #c0caf5;
        }

        #backlight {
          color: #c0caf5;
        }

        label.numlock {
          color: #c0caf5;
        }

        label.numlock.locked {
          color: #c0caf5;
        }

        #pulseaudio {
          color: #c0caf5;
        }

        #pulseaudio.muted {
          color: #c0caf5;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
        }

        #idle_inhibitor {
          color: #c0caf5;
        }

        #idle_inhibitor.activated {
          color: #c0caf5;
        }
      '';
    };
  };
}
