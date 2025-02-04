{ pkgs, inputs, ... }: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  }; in
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ /* Essential */
    unstable.lutris
    unstable.zed-editor
    heroic
    vscode
    mangohud
    obsidian
    godot_4
    blender
    authenticator
    nautilus
    swayimg
    vlc
    chatterino2
    kdenlive
    krita
    obs-studio
    kwrited
    gimp
    baobab
    gnome-calendar
    nextcloud-client
  ]; /*
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  }; */
}
