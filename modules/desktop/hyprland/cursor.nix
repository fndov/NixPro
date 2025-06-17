{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    cursorSize = 26;
    cursorSizeStr = toString cursorSize;
    cursorThemeName = "catppuccin-mocha-dark-cursors";
  in {
    gtk.cursorTheme.name = cursorThemeName;
    gtk.cursorTheme.package = pkgs.catppuccin-cursors.mochaDark;
    gtk.cursorTheme.size = cursorSize;
    home.pointerCursor.gtk.enable = true;
    home.pointerCursor.x11.enable = true;
    home.pointerCursor.name = cursorThemeName;
    home.pointerCursor.package = pkgs.catppuccin-cursors.mochaDark;
    home.pointerCursor.size = cursorSize;
    home.sessionVariables.XCURSOR_THEME = cursorThemeName;
    home.sessionVariables.XCURSOR_SIZE  = cursorSizeStr;
    wayland.windowManager.hyprland.settings.env = [
      "XCURSOR_SIZE=${cursorSizeStr}"
      "XCURSOR_THEME=${cursorThemeName}"
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprctl setcursor ${cursorThemeName} ${cursorSizeStr}"
    ];
    wayland.windowManager.hyprland.settings.cursor.no_warps = false;
    wayland.windowManager.hyprland.settings.cursor.inactive_timeout = 7;
    wayland.windowManager.hyprland.settings.cursor.enable_hyprcursor = true;
    wayland.windowManager.hyprland.settings.cursor.sync_gsettings_theme = true;
  };
}
