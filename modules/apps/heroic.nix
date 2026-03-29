{ pkgs, unstable, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: {
    home.packages = with pkgs; [
      heroic
      gamemode
      protonup-ng
      mangohud
      gamescope
      unstable.wine
      /*
        protontricks
        protonplus
        winetricks
      */
    ];
  };
}
