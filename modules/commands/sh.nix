{ pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { ... }: let
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
      n = if settings.user.editor == "micro"
        then "${settings.user.editor} --ruler false -colorscheme geany ~/Documents/note.txt"
      else "${settings.user.editor} ~/Documents/note.txt";
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
        # bind \x7f backward-kill-word
        bind \cF nixsw
        bind \cH backward-kill-word
      '';
      shellAliases = aliases;
    };
    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = aliases;
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
    programs.git.enable = true;
    programs.git.userName = settings.user.name;
    programs.git.userEmail = settings.user.email;
    programs.git.extraConfig = {
      core.editor = settings.user.editor;
      safe.directory = [
        ("/home/" + settings.user.name + "/." + settings.system.flakePath + "/")
        ("/home/" + settings.user.name + "/." + settings.system.flakePath + "/.git")
      ];
    };
  };
}
