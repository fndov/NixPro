{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = [ pkgs.chromium ];
    xdg.mimeApps.defaultApplications = {
      "text/html" = "chromium-browser.desktop";
      "x-scheme-handler/http" = "chromium.desktop";
      "x-scheme-handler/https" = "chromium.desktop";
      "x-scheme-handler/about" = "chromium.desktop";
      "x-scheme-handler/unknown" = "chromium.desktop";
    };
    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.chromium}/bin/chromium";
    };
  };
}
