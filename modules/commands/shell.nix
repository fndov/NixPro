{ lib, inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
    aliases = {
      shell = "nix-shell";
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
        else if settings.account.editor == "doom"
          then "nice -1 ${settings.account.editor}"
        else "nice -1 ${settings.account.editor}";
      cattree = "find . -type f -exec grep -Iq . {} \\; -print | xargs cat";
      offload = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia";
      gc = "git clone";
      ultra = "zstd --ultra 22";
      nixsh = "nix-shell --command ${settings.account.shell} -p";
      tmpd = "mkdir /tmp/d 2>/dev/null || true && cd /tmp/d 2>/dev/null || true";
      rmtmpd = "rm -rf /tmp/d/*";
      scp = "scp -r";
    };
  in {
    config = lib.mkMerge [
      {
        home.packages = with pkgs; [
          unstable.eza
          unstable.fd
          unstable.ripgrep
          glib
          glibc
        ];
        programs.powerline-go.enable = true;
        programs.atuin.enable = true;
        programs.atuin.enableBashIntegration = true;
        programs.zoxide.enable = true;
        programs.zoxide.enableZshIntegration = true;

        programs.git.enable = true;
        programs.git.userName = settings.account.name;
        programs.git.userEmail = settings.account.email;
        programs.git.extraConfig.core.editor = settings.account.editor;
        programs.git.extraConfig.safe.directory = [
          ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/")
          ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/.git")
        ];
      }
      (if settings.account.shell == "bash" then {} else {})
      (if settings.account.shell == "zsh" then {
        programs.zsh = {
          enable = true;
          enableCompletions = true;
          autosuggestions.enable = true;
          syntaxHighlighting.enable = true;
          shellAliases = aliases;
        };
        programs.atuin.enableZshIntegration = true;
      } else {})
      (if settings.account.shell == "fish" then {
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
          bind \cN "nix-shell"
        '';
        programs.fish.shellAliases = aliases;
        home.packages = with pkgs; [ fishPlugins.done ];
        programs.atuin.enableFishIntegration = true;
      } else {})
      (if settings.account.shell == "nushell" then {
        programs.nushell.enable = true;
        programs.atuin.enableNushellIntegration = true;
      } else {})
    ];
  };
}
