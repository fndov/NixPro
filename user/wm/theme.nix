{ pkgs, userSettings, lib, ... }: {
  dconf.enable = true;
  dconf.settings = { "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; }; };
  
  # catppuccin.gtk.tweaks = [ "rimless" ];
  # catppuccin.gtk.size = "compact";
  # catppuccin.gtk.enable = true;

  gtk = { 
    enable = true;
    font.name = userSettings.font;
    font.package = pkgs.${userSettings.fontPkg};
    font.size = 11;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
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
