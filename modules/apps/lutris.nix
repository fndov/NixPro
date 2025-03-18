{ pkgs, inputs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
in {
  home-manager.users.${settings.user.name} = { pkgs, inputs, ... }: {
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
