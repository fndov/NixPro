{ systemSettings, userSettings, pkgs, ... }:
let
  myAliases = {
    cat = "bat --style=plain --pager=never";
    tree = "eza --color always --icons --hyperlink --group-directories-first --tree";
    l = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2";
    ll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links";
    la = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links --all";
    ls = "eza --icons";
    c = "clear;date";
    grep = "rg";
    n = "${userSettings.editor} ~/Documents/note.txt";
    h = "htop";
    fd = "fd -Lu";
    fetch = "fastfetch";
    f = "yazi";
    trash = "gio trash";
    e = "${userSettings.editor}";
    rollback = "sudo nixos-rebuild switch --flake /home/${userSettings.username}/${systemSettings.flakePath}#${userSettings.username} --rollback";
    flake = "printf '\n';bash -c 'sudo nixos-rebuild switch --flake /home/${userSettings.username}/${systemSettings.flakePath}#${userSettings.username} |& nom';printf '\n'";
  };
in {
  home.packages = with pkgs; [
    micro
    # userSettings.terminal
    bat
    eza
    ripgrep
    htop
    fd
    fastfetch
    yazi
    glibc
    glib
    nix-output-monitor
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit =
      "set fish_greeting;bind \\cH backward-kill-word;bind \\cF flake";
    shellAliases = myAliases;
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    # initExtra = "clear";
  };
  programs.powerline-go = { enable = true; };
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
}
