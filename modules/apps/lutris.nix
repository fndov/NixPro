{ pkgs, inputs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
in {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      unstable.lutris
      unstable.gamemode
      unstable.protonup
      unstable.mangohud
      unstable.wine
      # unstable.protontricks
      # unstable.protonplus
      # unstable.winetricks
    ];
  };
}
