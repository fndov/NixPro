{ pkgs, settings, ... }: {
  home.packages = with pkgs; [
    pamixer
    playerctl
    brightnessctl
  ];
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];
    bind = [
      # Apps.
      "SUPER,Return,exec,${settings.user.terminal}"
      "SUPER,Z,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e ${settings.user.editor} ~/Documents/note.txt'"
      "SUPER,B,exec,hyprctl dispatch exec '[float] ${settings.user.terminal} -e btm'"
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

      # Window Control.
      "SUPER,SPACE,fullscreen,1"
      "SUPERSHIFT,F,fullscreen,0"
      "SUPER,Y,workspaceopt,allfloat"
      "ALT,TAB,cyclenext"
      "ALT,TAB,bringactivetotop"
      "ALTSHIFT,TAB,cyclenext,prev"
      "ALTSHIFT,TAB,bringactivetotop"
      # "SUPER,V,exec,wl-copy $(wl-paste | tr '\n' ' ')"
      "SUPERSHIFT,T,exec,screenshot-ocr"
      "CTRLALT,Delete,exec,hyprctl kill"
      "SUPERSHIFT,Q,exec,hyprctl kill"

      # Volume and Media Control.
      ", XF86AudioRaiseVolume, exec, pamixer --unmute -i 3"
      ", XF86AudioLowerVolume, exec, 'pamixer --unmute --allow-boost -d 3'"
      "SUPER, XF86AudioRaiseVolume, exec, pamixer --unmute --allow-boost -i 3"
      ",XF86AudioMicMute,exec,pamixer --default-source -m"
      ",XF86AudioMute,exec,pamixer -t"
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPause,exec,playerctl play-pause"
      ",XF86AudioNext,exec,playerctl next"
      ",XF86AudioPrev,exec,playerctl previous"

      # Brightness Control.
      ",XF86MonBrightnessDown,exec,brightnessctl set 3%-"
      ",XF86MonBrightnessUp,exec,brightnessctl set +3%"
      "SUPER,XF86MonBrightnessDown,exec,brightnessctl set 1%-"
      "SUPER,XF86MonBrightnessUp,exec,brightnessctl set +1%"

      # Volume Control.
      ",XF86AudioLowerVolume,exec,pamixer -d 2"
      ",XF86AudioRaiseVolume,exec,pamixer -i 2"

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
