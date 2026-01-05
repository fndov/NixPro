{ inputs, pkgs, settings, ... }: {
  nixpkgs.config.allowUnfree = true;
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      /* Non-essential */
      yt-dlp
      bat # Better cat
      weechat
      file
      unstable.gdu
      unstable.fastfetch
      unstable.numbat
      sysz # Systemd service viewer
      gemini-cli
      unstable.codex
      nix-output-monitor
      discordchatexporter-cli
      discordchatexporter-desktop
      lazygit # Git tui
      dust # Better `du`
      gping # Better `ping`
      lolcat
      hyperfine # Better `time`
      broot # Interactive directory tree navigator
      unstable.ollama
      wget
      /*
        kmon
        timg
        chafa
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
        helvum
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
