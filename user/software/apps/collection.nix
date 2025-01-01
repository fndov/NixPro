{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    lutris
    wine
    heroic
    mangohud
    authenticator
    swayimg
    nautilus
    vlc
    vscode
    baobab
    blender
    chatterino2
    godot_4
    kcalc
    kdenlive
    krita
    obs-studio
    telegram-desktop
    kwrited
    obsidian
    zed-editor
    # unityhub
    # mpv
    # lutris
    # NEW:
    # Apps:
    # aseprite
    # beaver-notes
    # davinci-resolve
    # handbrake
    # helvum
    # jetbrains-toolbox
    # jetbrains.aqua
    # jetbrains.clion
    # jetbrains.datagrip
    # jetbrains.dataspell
    # jetbrains.goland
    # jetbrains.idea-ultimate
    # jetbrains.phpstorm
    # jetbrains.pycharm-community
    # jetbrains.pycharm-professional
    # jetbrains.rider
    # jetbrains.ruby-mine
    # jetbrains.rust-rover
    # jetbrains.webstorm
    # k3b
    # kaddressbook
    # kontact
    # korganizer
    # mission-center
    # mpv
    # remembrance
    # steam
    # veracrypt
    # zen-browser
    # portmaster
    # upscayl
    # tor-browser-bundle-bin
    # qbittorrent
    # isoimagewriter
  ];
}
