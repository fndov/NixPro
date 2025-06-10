{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      nautilus
      pix
      networkmanagerapplet /*
      papirus-icon-theme
      fnott
      fuzzel
      gsettings-desktop-schemas
      gtklock
      hypridle
      hyprland-protocols
      hyprlock
      hyprpicker
      keepmenu
      killall
      libinput-gestures
      libsForQt5.qt5.qtwayland
      libva-utils
      nwg-launchers
      pamixer
      pavucontrol
      pinentry-gnome3
      polkit_gnome
      qt6.qtwayland
      swaybg
      swayidle
      tesseract4
      wev
      wlr-randr
      wlsunset
      wtype
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-utils
      ydotool
      zenity
      hyprcursor */
    ];
  };
}
