{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = [ pkgs.firefox-bin ];
    xdg.mimeApps.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.firefox-bin}/bin/firefox";
    };
  } // (if settings.desktop.type == "hyprland" then {
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.firefox-bin}/bin/firefox"
    ];
    wayland.windowManager.hyprland.settings.env = [
      "MOZ_ENABLE_WAYLAND,1"
      "BROWSER,${settings.account.browser}"
    ];
  } else {});
}
