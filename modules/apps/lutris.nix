{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with pkgs; [
      lutris
      unstable.gamemode
      unstable.gamescope
      unstable.gvfs
      unstable.mangohud
      unstable.protonup
      unstable.wine
      unstable.vulkan-tools
      unstable.vulkan-loader
      /*
        unstable.protontricks
        unstable.protonplus
        unstable.winetricks
      */
    ];
  };
  nixpkgs.config.allowUnfree = true;
  programs.gamemode.enable = true;
}
