{ inputs, pkgs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in {
  home-manager.users.${settings.user.name} = { inputs, pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      /* Essential */
      nixd
      nil
      zip
      unzip
      glib
      glibc
      usbutils
      hwinfo
      pciutils
      curl
      git
      loop
      /* Extra */
      appimage-run
      gdu
      fastfetch
      compsize
      libnotify
      numbat
      /*
        exif
        nixfmt-classic
        syncthing
        openssh
        sshpass
        glances
        wget
        ffmpeg
        bottom
        gamemode
        aria2
        cava
        cowsay
        fzf
        p7zip
        twitch-dl
        unrar
        yt-dlp
        aircrack-ng
        ascii-image-converter
        carapace
        corefonts
        dialog
        discordchatexporter-cli
        dmidecode
        egl-wayland
        fastgame
        gophish
        hashcat
        helix
        icu
        jre
        lolcat
        mat2
        nethogs
        nftables
        nix-prefetch-github
        nixfmt-classic
        nixpkgs-review
        raylib
        scc
        ssh-chat
        sshs
        streamlink
        scc
        tmux
        gping
        vulkan-tools
      */
    ];
  };
}
