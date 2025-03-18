{ pkgs, settings, lib, ... }: {
  config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        pamixer
        playerctl
        brightnessctl
        swayosd
      ];
      home.file.".config/swayosd/style.css".text = ''
        window {
        background-color: rgba(30, 30, 46, 0.8);
        color: #CDD6F4; /* Text */
        border-radius: 12px;
        margin: 16px;
        padding: 16px;
        }
        progressbar {
        margin: 8px;
        }
        progressbar trough {
        background-color: #313244;
        border-radius: 8px;
        min-height: 10px;
        }
        progressbar progress {
        border-radius: 8px;
        min-height: 10px;
        background-color: #B4B4D4;
        }
        .volume progressbar progress {
        background-color: #89DCEB;
        }
        .volume.muted progressbar progress {
        background-color: #F38BA8;
        }
        .brightness progressbar progress {
        background-color: #F9E2AF;
        }
        label {
        color: #CDD6F4;
        font-family: "Sans";
        font-size: 14px;
        margin: 5px;
        }
        image {
        color: #CDD6F4;
        margin: 8px;
        }
        #capslock-indicator {
        background-color: #A6E3A1; /* Green */
        color: #1E1E2E;
        padding: 8px;
        border-radius: 6px;
        font-weight: bold;
        margin: 5px;
        }
        #numlock-indicator {
        background-color: #F9E2AF; /* Yellow */
        color: #1E1E2E;
        padding: 8px;
        border-radius: 6px;
        font-weight: bold;
        margin: 5px;
        }
        #scrolllock-indicator {
        background-color: #FAB387; /* Peach */
        color: #1E1E2E;
        padding: 8px;
        border-radius: 6px;
        font-weight: bold;
        margin: 5px;
        }
        * {
        border: none;
        box-shadow: none;
        }
      '';
      wayland.windowManager.hyprland.settings = {
        exec-once = [ "swayosd-server" ];
        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];
        bind = [
          # Apps.
          "SUPER,Return,exec,${settings.user.terminal}"
          "SUPER,H,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e htop'"
          "SUPER,N,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e numbat'"

          # Common.
          "SUPER,Q,killactive"
          "SUPER,E,exec,systemctl suspend"
          "SUPERSHIFT,E,exec,hyprlock & sleep 1;systemctl suspend"
          "SUPER,F,fullscreen"
          "SUPER,T,togglefloating"
          "SUPER,H,movefocus,left"
          "SUPER,J,movefocus,down"
          "SUPER,K,movefocus,up"
          "SUPER,L,movefocus,right"
          "SUPER,P,pin"
          "SUPERSHIFT,H,swapwindow,left"
          "SUPERSHIFT,J,swapwindow,down"
          "SUPERSHIFT,K,swapwindow,up"
          "SUPERSHIFT,L,swapwindow,right"
          ",Caps_Lock,exec, sleep 0.1;swayosd-client --caps-lock"

          # Window Control.
          "SUPER,SPACE,fullscreen,1"
          "SUPERSHIFT,F,fullscreen,0"
          "SUPER,Y,workspaceopt,allfloat"
          "ALT,TAB,cyclenext"
          "ALT,TAB,bringactivetotop"
          "ALTSHIFT,TAB,cyclenext,prev"
          "ALTSHIFT,TAB,bringactivetotop"
          "SUPERSHIFT,T,exec,screenshot-ocr"
          "CTRLALT,Delete,exec,hyprctl kill"
          "SUPERSHIFT,Q,exec,hyprctl kill"

          # Volume and Media Control.
          ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
          ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
          "SUPER,XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise --max-volume 200"
          "SUPER,XF86AudioLowerVolume, exec, swayosd-client --output-volume lower --max-volume 200"
          ",XF86AudioMute,exec, swayosd-client --output-volume mute-toggle"
          ",XF86AudioPlay,exec,playerctl play-pause"
          ",XF86AudioPause,exec,playerctl play-pause"
          ",XF86AudioNext,exec,playerctl next"
          ",XF86AudioPrev,exec,playerctl previous"

          # Brightness Control.
          ",XF86MonBrightnessUp,exec,swayosd-client --brightness raise"
          ",XF86MonBrightnessDown,exec,swayosd-client --brightness lower"
          "SUPER,XF86MonBrightnessUp,exec, swayosd-client --brightness +1"
          "SUPER,XF86MonBrightnessDown,exec, swayosd-client --brightness -1"

          # Volume Control.
          ",XF86AudioRaiseVolume,exec, pswayosd-client --output-volume raise"
          ",XF86AudioLowerVolume,exec, pswayosd-client --output-volume lower"

          # Workspace.
          "SUPER,1,workspace,1"
          "SUPER,2,workspace,2"
          "SUPER,3,workspace,3"
          "SUPER,4,workspace,4"
          "SUPER,5,workspace,5"
          "SUPER,6,workspace,6"
          "SUPER,7,workspace,7"
          "SUPER,8,workspace,8"
          "SUPER,9,workspace,9"
          "SUPER,0,workspace,0"
          "SUPERSHIFT,1,movetoworkspace,1"
          "SUPERSHIFT,2,movetoworkspace,2"
          "SUPERSHIFT,3,movetoworkspace,3"
          "SUPERSHIFT,4,movetoworkspace,4"
          "SUPERSHIFT,5,movetoworkspace,5"
          "SUPERSHIFT,6,movetoworkspace,6"
          "SUPERSHIFT,7,movetoworkspace,7"
          "SUPERSHIFT,8,movetoworkspace,8"
          "SUPERSHIFT,9,movetoworkspace,9"
        ];
      };
    }
    (if settings.user.editor == "micro" then {
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER,Z,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e ${settings.user.editor} --ruler false -colorscheme geany ~/Documents/note.txt'"
      ];
    } else {}) (if settings.user.editor == "nano" then {
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER,Z,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e ${settings.user.editor} ~/Documents/note.txt'"
      ];
    } else {})
    (if settings.user.editor == "neovim" then {
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER,Z,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e ${settings.user.editor} ~/Documents/note.txt'"
      ];
    } else {})
    (if settings.user.editor == "vim" then {
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER,Z,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e ${settings.user.editor} ~/Documents/note.txt'"
      ];
    } else {})
  ];
}
