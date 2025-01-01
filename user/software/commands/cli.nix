{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Essential:
    # appimage-run
    git
    timg
    nixd
    nil

    # System utils:
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
    # flatpak
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
    # tmux # I hate tmux.
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
    # gdu
    glib
    glibc
    # gping
    hwinfo
    # ifuse
    killall
    # libnotify
    # lolcat
    mangohud
    nixfmt-classic
    numbat
    nvtopPackages.full
    openssh
    p7zip
    pciutils
    # protonplus
    # protontricks
    # protonup
    # scc
    twitch-dl
    unrar
    unzip
    # vulkan-tools
    wine
    yazi
    yt-dlp
    zip
  ];
}
