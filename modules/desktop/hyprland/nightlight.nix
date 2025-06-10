{ settings, ... }: {
  home-manager.users.${settings.account.name}.services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = "31.0";
    longitude = "-97.5";
    dawnTime = "7:00-8:00";
    duskTime = "19:00-20:00";
    temperature.day = 6500;
    temperature.night = 3500;
    settings.general.adjustment-method = "wayland";
  };
}
