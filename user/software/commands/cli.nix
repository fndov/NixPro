{ pkgs, settings, ... }: {
  home.packages = with pkgs; [ /* Essential utils */
    nixd
    nil
    nixfmt-classic
    syncthing
    zip
    unzip
    glib
    glibc
    usbutils
    hwinfo
    openssh
    pciutils
    curl
    git
    sshpass
    wget
    # Extra.
    libnotify
    numbat
    ffmpeg 
    fastfetch /*
    unstable.wine
    bottom
    protonplus
    protontricks
    protonup
    gamemode
    gamescope
    aria2
    killall
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
    nmap
    raylib
    scc
    spacevim
    ssh-chat
    sshs
    streamlink
    scc
    tmux
    gping
    vulkan-tools
    gdu
    lolcat */
  ];
  programs.git.enable = true;
  programs.git.userName = settings.user.name;
  programs.git.userEmail = settings.user.email;
  programs.git.extraConfig = {
    core.editor = settings.user.editor;
    # init.defaultBranch = "main";
    safe.directory = [
      ("/home/" + settings.user.name + "/.nixpro")
      ("/home/" + settings.user.name + "/.nixpro/.git")
    ];
  };
}
