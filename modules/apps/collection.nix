{ inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { pkgs, ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      unstable.zed-editor
      obsidian
      vscode
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
      libreoffice
      vlc
      /*
        qbittorrent
        protonvpn-gui
        upscayl
        foliate
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
        remembrance
        veracrypt
        zen-browser
        portmaster
        tor-browser-bundle-bin
        isoimagewriter
      */
    ];
  };
}
