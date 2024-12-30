{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Essential:
    appimage-run
    zoxide
    ripgrep
    fd
    micro
    atuin
    git
    eza
    timg
    htop

    inputs.nsearch.packages.${pkgs.system}.default

    # System utils:
    # aircrack-ng
    # ascii-image-converter
    # bash
    # bloodhound
    # carapace
    # corefonts
    # dialog 
    # discordchatexporter-cli
    # dmidecode
    # egl-wayland
    # exif
    # fastgame
    # fish
    # flatpak
    # gdu
    # gophish
    # hashcat
    # helix
    # icu
    # jre
    # kubectl
    # lolcat
    # masscan
    # mat2
    # metasploit
    # nethogs
    # nftables
    # nil
    # nix-prefetch-github
    # nixd
    # nixfmt-classic
    # nixpkgs-review
    # nmap
    # raylib
    # scc
    # spacevim
    # ssh-chat
    # sshs
    # streamlink
    # tmux
    # tmuxPlugins.tmux-floax
    # yazi
    # nixd
    # usbutils
    aria2
    bat
    cargo
    cava
    cowsay
    curl
    disfetch
    fastfetch
    fzf
    gamemode
    gamescope
    gcc
    gdu
    glib
    glibc
    gping
    hwinfo
    ifuse
    killall
    libnotify
    linuxPackages.nvidia_x11
    lolcat
    mangohud
    mesa
    neovide
    neovim
    nixfmt-classic
    numbat
    nvtopPackages.full
    openssh
    p7zip
    pciutils
    protonplus
    protontricks
    protonup
    python312
    scc
    twitch-dl
    unrar
    unzip
    vulkan-tools
    wine
    winetricks
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    yazi
    yt-dlp
    zip
  ];
}
