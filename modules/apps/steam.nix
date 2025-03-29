{ inputs, settings, pkgs, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
in {
  home-manager.users.${settings.account.name} = { pkgs, ... }: {
    home.packages = with pkgs; [
      unstable.steam
      unstable.gamemode
      unstable.mangohud
      unstable.protonup
      unstable.wine
      /*
        unstable.protontricks
        unstable.protonplus
        unstable.winetricks
      */
    ];
  };
  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;
  hardware.steam-hardware.enable = true;
  nixpkgs.config.allowUnfree = true;
}
