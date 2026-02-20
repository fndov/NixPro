{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: {
    home.packages = with pkgs; [
      heroic
      gamemode
      protonup-ng
      mangohud
      wine
      gamescope
      /*
        protontricks
        protonplus
        winetricks
      */
    ];
  };
}
