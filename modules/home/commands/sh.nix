{ pkgs, settings, ... }: let
  myAliases = {
    cat = "bat --style=plain --pager=never";
    tree = "eza --color always --icons --hyperlink --group-directories-first --tree";
    l = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2";
    ll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links";
    la = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links --all";
    ls = "eza --icons";
    c = "clear";
    cc = "clear;cd";
    ccc = "clear;cd /mnt/c/Users/miyu/";
    grep = "rg";
    n = "${settings.user.editor} ~/Documents/note.txt";
    h = "htop";
    fd = "fd -Lu";
    fetch = "fastfetch";
    f = "yazi";
    trash = "gio trash";
    e = if settings.user.editor == "micro" 
      then "${settings.user.editor} --ruler false -colorscheme geany" 
    else settings.user.editor;
    cattree = "find . -type f -exec grep -Iq . {} \\; -print | xargs cat";
    offload = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia";
    }; 
in { 
  home.packages = with pkgs; [
    bat
    eza
    fastfetch
    fd
    glib
    glibc
    htop
    mako
    micro
    ripgrep
    openssh
    libnotify
    yazi
    timg
    fishPlugins.done
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting ""
      # bind \cH backward-kill-word
      # bind \x7f backward-kill-word
      bind \cF nixsw
    '';
    shellAliases = myAliases;
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
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
