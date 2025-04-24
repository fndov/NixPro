{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with pkgs; [
      lutris
      unstable.gamemode
      unstable.gamescope
      unstable.protonup
      unstable.mangohud
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
}
