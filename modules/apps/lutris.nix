{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      lutris
      gamemode
      gamescope
      gvfs
      vulkan-tools
      vulkan-loader
      mangohud
      protonplus
      wine
      /*
        protontricks
        protonplus
        protonup
        winetricks
      */
    ];
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  hardware.steam-hardware.enable = true;
  nixpkgs.config.allowUnfree = true;
}
