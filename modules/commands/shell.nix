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
          else "nice -1 ${settings.account.editor}";
      cattree = "find . -type f -exec grep -Iq . {} \\; -print | xargs cat";
      offload = "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia";
      gc = "git clone";
      ultra = "zstd --ultra 22";
      nixsh = "nix-shell -p";
      tmpd = "mkdir /tmp/d 2>/dev/null || true && cd /tmp/d 2>/dev/null || true";
      rmtmpd = "rm -rf /tmp/d/*";
    };
  in {
    config = lib.mkMerge [
      {
        home.packages = with pkgs; [
          unstable.appimage-run
          unstable.eza
          unstable.fd
          unstable.ripgrep
          glib
          glibc
        ];
        programs.powerline-go.enable = true;
        # programs.powerline-go.settings."-theme" = "gruvbox";
        programs.atuin.enable = true;
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
      (if settings.account.shell == "bash" then {
        programs.bash.enable = true;
        programs.atuin.enableBashIntegration = true;
      } else {})
      (if settings.account.shell == "zsh" then {
        home.packages = with unstable; [
          zsh-autosuggestions
          zsh-syntax-highlighting
          zsh-completions
        ];
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          shellAliases = aliases;
          initContent = ''
            # No greeting
            unsetopt BEEP
            PROMPT='%(?.%F{green}❯%f.%F{red}❯%f) '

            # Bindings to mimic Fish
            bindkey -s '^F' 'nixsw\n'
            bindkey -s '^T' 'nixts\n'
            bindkey -s '^K' 'up-line-or-search\n'
            bindkey -s '^E' '${settings.account.editor}\n'
            bindkey -s '^W' 'weechat\n'
            bindkey -s '^X' 'cargo run\n'
            bindkey -s '^N' 'nix-shell\n'

            # Autocomplete settings like Fish
            autoload -Uz compinit
            compinit
            zstyle ':completion:*' menu select
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
            zstyle ':completion:*' accept-exact '*(N)'
            zstyle ':completion:*' completer _expand _complete _ignored _approximate
            zstyle ':completion:*:approximate:*' max-errors 1

            # Plugins
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          '';
        };
        programs.atuin.enableZshIntegration = true;
      } else {})
      (if settings.account.shell == "fish" then {
        home.packages = with pkgs; [
          fishPlugins.done
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
          bind \cN "nix-shell"
        '';
        programs.fish.shellAliases = aliases;
        programs.atuin.enableFishIntegration = true;
      } else {})
      (if settings.account.shell == "nushell" then {
        programs.nushell.enable = true;
        programs.atuin.enableNushellIntegration = true;
      } else {})
    ];
  };
}
