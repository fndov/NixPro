{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; config.allowUnfree = true; };
  in {
    home.packages = with pkgs; [
      heroic
      gamemode
      protonup-ng
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
