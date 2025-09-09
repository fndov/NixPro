{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with pkgs; [
      lutris
      gamemode
      gamescope
      gvfs
      mangohud
      unstable.protonup
      unstable.wine
      vulkan-tools
      vulkan-loader
      /*
        protontricks
        protonplus
        winetricks
      */
    ];
  };
  nixpkgs.config.allowUnfree = true;
  programs.gamemode.enable = true;
}
