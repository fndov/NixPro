{ inputs, pkgs, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
in {
  home.packages = with pkgs; [
    unstable.heroic
    unstable.gamemode
    unstable.protonup
    unstable.mangohud
    unstable.wine
    # unstable.protontricks
    # unstable.protonplus
    # unstable.winetricks
  ];
}
