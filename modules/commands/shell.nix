{ lib, inputs, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; };
    aliases = {
      shell = "nix-shell";
      vstart = "sudo virsh net-start default";
      reboot = "echo '# Refusing to reboot'";
      poweroff = "echo '# Refusing to poweroff'";
      tree = "eza --color always --icons --hyperlink --group-directories-first --tree";
      l = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2";
      ll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=3"; 
      lll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=4"; 
      llll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=5"; 
      lllll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=6"; 
      llllll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=7"; 
      lllllll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=8"; 
      llllllll = "eza --color always --icons --hyperlink --group-directories-first --tree --level=9"; 
      li = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links";
      la = "eza --color always --icons --hyperlink --group-directories-first --tree --level=2 --long --header --inode --links --all";
      ls = "eza --icons";
      c = "clear";
      cc = "clear;cd";
      ccc = "clear;cd /mnt/c/Users/miyu/";
      cat = "bat --style=plain --pager=never";
      ccat = "clear;bat --style=plain --pager=never";
      cs = "clear;ls";
      cp = "cp -r";
      scp = "scp -r";
      mkdir = "mkdir -p";
      x = "codex";
      grep = "rg";
      n = if settings.account.editor == "micro" then
        "${settings.account.editor} --ruler false -colorscheme geany ~/Documents/note.txt"
      else
        "${settings.account.editor} ~/Documents/note.txt";
      h = "htop";
      fd = "fd -Lu";
      fetch = "fastfetch";
      f = "yazi";
      trash = "gio trash";
      e = if settings.account.editor == "micro" then
        "nice -1 ${settings.account.editor} --ruler false -colorscheme geany"
      else if settings.account.editor == "flow" then
        "nice -1 ${settings.account.editor}"
      else if settings.account.editor == "doom" then
        "nice -1 ${settings.account.editor}"
      else
        "nice -1 ${settings.account.editor}";
      offload = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia";
      gc = "git clone --dep 1";
      ultra = "zstd --ultra -22";
      nixsh = "nix-shell --command ${settings.account.shell} -p";
      tmpd = "mkdir /tmp/d 2>/dev/null || true && cd /tmp/d 2>/dev/null || true";
      rmtmpd = "rm -rf /tmp/d/*";
      throttle = "taskset -c 0-5";
      dustt = "dust --depth 1";
      py = "python";
    };
  in { config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        unstable.eza
        unstable.fd
        unstable.ripgrep
        unstable.fzf
        glib
        glibc
        (writeShellScriptBin "mc" ''
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          appimage-run Archive/Appimages/PrismLauncher-Linux-x86_64.AppImage
        '')
      ];
      programs.powerline-go.enable = true;
      programs.atuin.enable = true;
      programs.atuin.enableBashIntegration = true;
      programs.zoxide.enable = true;
      programs.zoxide.enableZshIntegration = true;

      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;
      home.file.".config/direnv/direnv.toml".text = ''
        [global]
        hide_env_diff = true
      '';

      programs.git.enable = true;
      programs.git.settings.user.name = settings.account.name;
      programs.git.settings.user.email = settings.account.email;
      programs.git.settings.core.editor = settings.account.editor;
      programs.git.settings.safe.directory = [
        ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/")
        ("/home/" + settings.account.name + "/." + settings.system.flakePath + "/.git")
      ];
    }
    (if settings.account.shell == "bash" then { } else { })
    (if settings.account.shell == "zsh" then {
      programs.zsh = {
        enable = true;
        enableCompletions = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = aliases;
      };
      programs.atuin.enableZshIntegration = true;
    } else { })
    (if settings.account.shell == "fish" then {
      programs.fish.enable = true;
      programs.fish.interactiveShellInit = ''
        set fish_greeting ""

        bind \cF nixsw
        bind \cT nixts
        bind \cS nixsw
        bind \cK "up-or-search; commandline -f execute"
        bind \cE e
        bind \cX codex
        bind \cH htop
        bind \cN "nix-shell"

        function ef --description "Edit file, fuzzy-pick a filename to open in editor"
          # List files (respects .gitignore by default) and pick one with preview.
          set -l file (rg --files | fzf --prompt="ef> " --height=80% --preview 'bat --style=plain --color=always {}' --preview-window='right,60%,wrap')
          test -n "$file"; or return
          ${settings.account.editor} "$file"
        end

        function rge --description "Ripgrep edit, enter text you're looking for and open that file in editor"
          set -l hit (rg --line-number --no-heading $argv | fzf --preview 'echo {} | cut -d: -f1 | xargs -I{} bat --style=plain --color=always {}')
          test -n "$hit"; or return
          set -l f (echo $hit | cut -d: -f1)
          set -l l (echo $hit | cut -d: -f2)
          set -l editor ${settings.account.editor}
          switch $editor
            case vi vim nvim
              $editor +$l "$f"
            case '*'
              $editor "$f"
          end
        end
      '';
      programs.fish.shellAliases = aliases;
      home.packages = with pkgs; [ fishPlugins.done ];
      programs.atuin.enableFishIntegration = true;
    } else { })
    (if settings.account.shell == "nushell" then {
      programs.nushell.enable = true;
      programs.atuin.enableNushellIntegration = true;
    } else { }) ];
  };
}
