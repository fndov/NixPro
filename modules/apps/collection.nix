{ inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      ghex                 # hexeditor
      unstable.komikku     # manga
      unstable.upscayl     # image upscale
      zed-editor           # my beloved IDE
      unstable.obsidian    # notes
      unstable.obs-studio  # screenrecording
      unstable.gimp        # the worst image editor
      libreoffice          # word
      video-trimmer
      krita                # art
      authenticator        # auth
      easyeffects          # audio stuff
      baobab               # disk usage app
      gearlever            # app image utility
      vesktop              # modded discord
      chatterino2          # twitch chat
      mgba                 # gameboy emulator
      /*
        vlc
        helvum
        open-webui
        slack
        unstable.code-cursor
        kdePackages.k3b # broken
        gnome-disk-utility
        portmaster
        qbittorrent
        amberol
        unstable.godot_4
        unstable.blender
        unstable.telegram-desktop
        swayimg
        kdenlive
        kdePackages.elisa
        gnome-calendar
        kwrited
        veracrypt
        k3b # Broken Wed Apr 2 04:27:23 PM CDT 2025
        vscode
        unstable.code-cursor
        unstable.alpaca
        protonvpn-gui
        discord
        foliate
        monero-gui
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
        telegram-desktop
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
        zen-browser
        tor-browser-bundle-bin
        isoimagewriter
        discord
      */
    ];
  };
  services.lact.enable = true;
}
