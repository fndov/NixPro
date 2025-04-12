{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    cursorSize = 26;
    cursorSizeStr = toString cursorSize;
    cursorThemeName = "catppuccin-mocha-dark-cursors";
  in {
    gtk.cursorTheme = {
      name = cursorThemeName;
      package = pkgs.catppuccin-cursors.mochaDark;
      size = cursorSize;
    };
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = cursorThemeName;
      package = pkgs.catppuccin-cursors.mochaDark;
      size = cursorSize;
    };
    home.sessionVariables = {
      XCURSOR_THEME = cursorThemeName;
      XCURSOR_SIZE  = cursorSizeStr;
    };
    wayland.windowManager.hyprland.settings = {
      env = [
        "XCURSOR_SIZE=${cursorSizeStr}"
        "XCURSOR_THEME=${cursorThemeName}"
      ];
      exec-once = [
        "hyprctl setcursor ${cursorThemeName} ${cursorSizeStr}"
      ];
      cursor = {
        no_warps = false;
        inactive_timeout = 7;
        enable_hyprcursor = true;
        sync_gsettings_theme = true;
      };
    };
  };
}
