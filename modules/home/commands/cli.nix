{ inputs, pkgs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in {
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
    /* Extra */
    gdu
    fastfetch
    compsize
    libnotify
    numbat
    /*
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
      appimage-run
      aircrack-ng
      ascii-image-converter
      carapace
      corefonts
      dialog
      discordchatexporter-cli
      dmidecode
      egl-wayland
      exif
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
}
