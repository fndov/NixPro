{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with pkgs; [
      unstable.heroic
      unstable.gamemode
      unstable.protonup
      unstable.mangohud
      unstable.wine
      unstable.gamescope
      /*
        unstable.protontricks
        unstable.protonplus
        unstable.winetricks
      */
    ];
  };
}
