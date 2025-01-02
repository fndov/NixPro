{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Essential:
    git
    timg
    nixd
    nil
    # System utils:
    # appimage-run
    # aircrack-ng
    # ascii-image-converter
    # carapace
    # corefonts
    # dialog
    # discordchatexporter-cli
    # dmidecode
    # egl-wayland
    # exif
    # fastgame
    # gophish
    # hashcat
    # helix
    # icu
    # jre
    # kubectl
    # lolcat
    # mat2
    # nethogs
    # nftables
    # nix-prefetch-github
    # nixfmt-classic
    # nixpkgs-review
    # nmap
    # raylib
    # scc
    # spacevim
    # ssh-chat
    # sshs
    # streamlink
    # scc
    # tmux # I hate tmux.
    # gping
    # vulkan-tools
    # gdu
    # libnotify
    # lolcat
    raylib
    usbutils
    aria2
    bat
    cava
    cowsay
    curl
    fastfetch
    fzf
    gamemode
    gamescope
    glib
    glibc
    hwinfo
    killall
    mangohud
    nixfmt-classic
    numbat
    openssh
    p7zip
    pciutils
    protonplus
    protontricks
    protonup
    twitch-dl
    unrar
    unzip
    wine
    yazi
    yt-dlp
    zip
  ];
}
