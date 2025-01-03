{ pkgs, userSettings, ... }: {
  dconf.enable = true;
  dconf.settings = { "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; }; };

  gtk = {
    enable = true;
    font.name = userSettings.font;
    font.size = 11;
    font.package = userSettings.fontPkg;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
  };

  home.packages = with pkgs; [
    breeze-gtk
    breeze-qt5
    breeze-icons
  ];
  qt.enable = true;
}

# gtk.gtk3.extraConfig = {
#   Settings = ''
#     gtk-application-prefer-dark-theme=1
#     gtk-cursor-theme-name=Catppuccin-Mocha-Dark-Cursors
#   '';
# };
# gtk.gtk4.extraConfig = {
#   Settings = ''
#     gtk-application-prefer-dark-theme=1
#     gtk-cursor-theme-name=Catppuccin-Mocha-Dark-Cursors
#   '';
# };

# dconf = {
#   enable = true;
#   settings = {
#     "org/gnome/desktop/interface" = {
#       color-scheme = "prefer-dark";
#       theme = "Dracula";
#     };
#   };
# };

# xdg.configFile = {
#   "gtk-4.0/assets".source =
#     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
#   "gtk-4.0/gtk.css".source =
#     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
#   "gtk-4.0/gtk-dark.css".source =
#     "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
# };
