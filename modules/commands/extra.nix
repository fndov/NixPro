{ inputs, pkgs, settings, ... }: {
  nixpkgs.config.allowUnfree = true;
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; };
  in {
    home.packages = with pkgs; [
      /* Non-essential */
      yt-dlp
      bat                         # Better cat
      weechat
      file
      sysz                        # Systemd service viewer
      nix-output-monitor
      discordchatexporter-cli
      discordchatexporter-desktop
      lazygit                     # Git tui
      gping                       # Better `ping`
      lolcat
      hyperfine                   # Better `time`
      broot                       # Interactive directory tree navigator
      wget
      vt-cli                      # Virus total cli, wish they had a gui for nixos.
      gdu
      fastfetch
      numbat
      unstable.gemini-cli
      unstable.codex
      unstable.ollama
      /*
        ffmpeg
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
