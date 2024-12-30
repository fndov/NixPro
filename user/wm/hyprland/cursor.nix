{ pkgs, ... }:
let
  cursorSize = 27;
  cursorSizeStr = toString cursorSize;
in {
  gtk.cursorTheme = {
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = cursorSize;
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = cursorSize;
  };
  wayland.windowManager.hyprland.settings = {
    env = [ "XCURSOR_SIZE=${cursorSizeStr}" ];
    exec-once =
      [ "hyprctl setcursor catppuccin-mocha-dark-cursors ${cursorSizeStr}" ];
    cursor = {
      no_warps = false;
      inactive_timeout = 7;
      enable_hyprcursor = true;
      sync_gsettings_theme = true;
    };
  };
}

