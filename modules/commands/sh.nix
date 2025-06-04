{ inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
    aliases = {
      cat = "bat --style=plain --pager=never";
      tree = "eza --color always --icons --hyperlink --group-directories-first --tree";
      l = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2";
      ll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links";
      la = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links --all";
      ls = "eza --icons";
      c = "clear";
      cc = "clear;cd";
      ccc = "clear;cd /mnt/c/Users/miyu/";
      cp = "cp -r";
      grep = "rg";
      n = if settings.account.editor == "micro"
        then "${settings.account.editor} --ruler false -colorscheme geany ~/Documents/note.txt"
      else "${settings.account.editor} ~/Documents/note.txt";
      h = "htop";
      fd = "fd -Lu";
      fetch = "fastfetch";
      f = "yazi";
      trash = "gio trash";
      e = if settings.account.editor == "micro"
        then "nice -1 ${settings.account.editor} --ruler false -colorscheme geany"
      else if settings.account.editor == "flow"
        then "nice -1 ${settings.account.editor}"
      else "nice -1 ${settings.account.editor}";
      cattree = "find . -type f -exec grep -Iq . {} \\; -print | xargs cat";
      offload = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia";
    };
  in {
    home.packages = with pkgs; [
      unstable.appimage-run
      unstable.eza
      unstable.fd
      glib
      glibc
      unstable.ripgrep
      unstable.fishPlugins.done
    ];
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting ""
        # bind \x7f backward-kill-word
        bind \cF nixsw
        bind \cT nixts
        bind \cK ls
        bind \cE e
        bind \cW weechat
        bind \cH backward-kill-word
      '';
      shellAliases = aliases;
    };
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
    programs.powerline-go.enable = true;
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
    programs.git.enable = true;
    programs.git.userName = settings.account.name;
    programs.git.userEmail = settings.account.email;
    programs.git.extraConfig = {
      core.editor = settings.account.editor;
      safe.directory = [
        ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/")
        ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/.git")
      ];
    };
  };
}
