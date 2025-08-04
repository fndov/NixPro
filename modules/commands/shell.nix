{ inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
    aliases = {
      vstart = "sudo virsh net-start default";
      reboot = "echo '# Refusing to reboot'";
      poweroff = "echo '# Refusing to poweroff'";
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
      gc = "git clone";
      ultra = "zstd --ultra 22";
      nixsh = "nix-shell -p";
      tmpd = "mkdir /tmp/d 2>/dev/null || true && cd /tmp/d 2>/dev/null || true";
    };
  in {
    home.packages = with pkgs; [
      unstable.appimage-run
      unstable.eza
      unstable.fd
      unstable.ripgrep
      unstable.fishPlugins.done
      glib
      glibc
    ];
    programs.fish.enable = true;
    programs.fish.interactiveShellInit = ''
      set fish_greeting ""
      bind \cF nixsw
      bind \cT nixts
      bind \cS nixsw
      bind \cK "up-or-search; commandline -f execute"
      bind \cE e
      bind \cW weechat
      bind \cX "cargo run"
      bind \cH backward-kill-word
    '';
    programs.fish.shellAliases = aliases;
    programs.zsh.enable = false;
    programs.bash.enable = true;
    programs.bash.enableCompletion = true;
    programs.powerline-go.enable = true;
    programs.atuin.enable = true;
    programs.atuin.enableFishIntegration = true;
    programs.atuin.enableBashIntegration = true;
    programs.zoxide.enable = true;
    programs.zoxide.enableFishIntegration = true;
    programs.zoxide.enableBashIntegration = true;
    programs.git.enable = true;
    programs.git.userName = settings.account.name;
    programs.git.userEmail = settings.account.email;
    programs.git.extraConfig.core.editor = settings.account.editor;
    programs.git.extraConfig.safe.directory = [
      ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/")
      ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/.git")
    ];
  };
}
