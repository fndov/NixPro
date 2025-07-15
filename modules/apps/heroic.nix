{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with unstable; [
      heroic
      gamemode
      protonup
      mangohud
      wine
      gamescope
      /*
        protontricks
        protonplus
        winetricks
      */
    ];
  };
}
