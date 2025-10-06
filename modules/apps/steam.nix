{ pkgs, inputs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      steam
      steam-run
      gamemode
      gamescope
      gvfs
      mangohud
      protonplus
      wine
      /*
        vulkan-tools
        vulkan-loader
        protonup
        protontricks
        winetricks
      */
    ];
  };
  programs.steam.extraCompatPackages = with unstable; [ proton-ge-bin ];
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
  nixpkgs.config.allowUnfree = true;
}
