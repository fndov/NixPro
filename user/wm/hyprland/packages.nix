{ pkgs, ... }: {
  # Hyprland WM.
  home.packages = with pkgs; [
    # Important.
    networkmanagerapplet
    wofi
    # Bloat.
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
    papirus-icon-theme
    pavucontrol
    pinentry-gnome3
    polkit_gnome
    qt6.qtwayland
    swaybg
    swayidle
    tesseract4
    wev
    wl-clipboard
    wlr-randr
    wlsunset
    wtype
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    ydotool
    zenity
    hyprcursor
  ];
}
