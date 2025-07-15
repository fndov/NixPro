{ inputs, settings, pkgs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with unstable; [
      steam
      gamemode
      gamescope
      gvfs
      mangohud
      protonup
      wine
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
