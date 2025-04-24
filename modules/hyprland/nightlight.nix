{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [ gammastep ];
    services.gammastep = {
      enable = true;
      latitude = "31.0";
      longitude = "-97.5";
      temperature.day = 6500;
      temperature.night = 3500;
      settings.general.adjustment-method = "wayland";
    };
  };
}
