{ inputs, pkgs, setttings, ... }: let
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
    /* Games */
    unstable.wine
    unstable.gamescope
    unstable.protonplus
    unstable.protontricks
    unstable.protonup
    /* Extra */
    fastfetch 
    compsize
    libnotify
    gdu
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
  programs.git.enable = true;
  programs.git.userName = settings.user.name;
  programs.git.userEmail = settings.user.email;
  programs.git.extraConfig = {
    core.editor = settings.user.editor;
    safe.directory = [
      ("/home/" + settings.user.name + "/.nixpro")
      ("/home/" + settings.user.name + "/.nixpro/.git")
    ];
  };
}
