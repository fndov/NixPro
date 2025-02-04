{ pkgs, inputs, ... }: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ /* Extra */
    unstable.wine
    libnotify
    numbat
    protonplus
    protontricks
    protonup
    fastfetch
    bottom
    ffmpeg /*
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
    lolcat
*/];
}
