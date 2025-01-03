{ pkgs, ... }: {
  home.packages = with pkgs; [
    # System utils:
    unzip
    wine
    yazi
    libnotify
    mangohud
    numbat
    protonplus
    protontricks
    protonup
    gamemode
    gamescope
    fastfetch
    bottom
    # aria2
    # killall
    # cava
    # cowsay
    # fzf
    # p7zip
    # twitch-dl
    # unrar
    # yt-dlp
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
    # tmux
    # gping
    # vulkan-tools
    # gdu
    # lolcat
  ];
}
