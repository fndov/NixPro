{ inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      /* Essential */
      zip
      unzip
      glib
      glibc
      curl
      git
      /* Extra */
      unstable.ollama
      unstable.nixd
      unstable.nil
      unstable.appimage-run
      unstable.gdu
      unstable.htop
      unstable.fastfetch
      compsize
      unstable.numbat
      /*
        loop
        toybox
        usbutils
        pciutils
        hwinfo
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
