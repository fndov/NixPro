{ pkgs, inputs, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; }; 
in {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ /* Essential. */
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
    chatterino2
    kdenlive
    krita
    obs-studio
    kwrited
    gimp
    baobab
    gnome-calendar
    libreoffice-fresh
    upscayl
    vlc /* Extra.
    foliate
    qbittorrent
    nextcloud-client
    lollypop
    xournalpp
    newsflash
    mate.atril
    gnome.adwaita-icon-theme
    shared-mime-info
    sshfs
    texinfo
    libffi
    zlib
    ventoy
    remmina
    tenacity
    rosegarden
    ardour
    audio-recorder
    libmediainfo
    mediainfo
    movit
    libresprite
    openvpn
    texliveSmall
    pinta
    inkscape
    unityhub
    bottles
    mpv
    aseprite
    beaver-notes
    davinci-resolve
    handbrake
    helvum
    jetbrains-toolbox
    jetbrains.aqua
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.dataspell
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.phpstorm
    jetbrains.pycharm-community
    jetbrains.pycharm-professional
    jetbrains.rider
    jetbrains.ruby-mine
    jetbrains.rust-rover
    jetbrains.webstorm
    k3b
    kaddressbook
    kontact
    korganizer
    mission-center
    mpv
    remembrance
    steam
    veracrypt
    zen-browser
    portmaster
    tor-browser-bundle-bin
    isoimagewriter */
  ]; /*
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  }; */
}
