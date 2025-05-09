{ pkgs, settings, ... }: {
  nixpkgs.config.allowUnfree = true;
  home-manager.users.${settings.account.name} = {
    home.packages = [ pkgs.google-chrome ];
    xdg.mimeApps.defaultApplications = {
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
    };
    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.google-chrome}/bin/google-chrome-stable";
    };
  } // (if settings.desktop.type == "hyprland" then {
    wayland.windowManager.hyprland.settings.exec-once = [
      "${pkgs.google-chrome}/bin/google-chrome-stable"
    ];
    wayland.windowManager.hyprland.settings.env = [
      "BROWSER,${settings.account.browser}"
      # Chrome uses ozone for Wayland, so you can enable it if desired:
      # "NIXOS_OZONE_WL,1"
    ];
  } else {});
}
