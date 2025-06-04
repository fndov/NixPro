{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = [
      unstable.rofi-wayland
      pkgs.cliphist
      pkgs.wl-clipboard
      unstable.nwg-clipman
    ];
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER,semicolon,exec,nice -21 rofi -show drun"
      "SUPER,V,exec, nice -21 nwg-clipman --window"
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "wl-paste --type text --watch cliphist store"
    ];
    home.file.".config/rofi/config.rasi".text = ''
      configuration{
          modi: "run,drun,window";
          icon-theme: "Oranchelo";
          show-icons: true;
          terminal: "${settings.account.terminal}";
          drun-display-format: "{icon} {name}";
          location: 0;
          disable-history: false;
          hide-scrollbar: true;
          display-drun: "  Apps ";
          display-run: "  Run ";
          display-window: "  Window ";
          display-Network: "  Network ";
          sidebar-mode: true;
      }

      @theme "~/.config/rofi/catppuccin-mocha.rasi"
    '';
    home.file.".config/rofi/catppuccin-mocha.rasi".text = ''
        * {
            bg-col:  #1e1e2e;
            bg-col-light: #1e1e2e;
            border-col: #3b3c47;
            selected-col: #1e1e2e;
            blue: #3b3c47;
            fg-col: #cdd6f4;
            fg-col2: #cdd6f4;
            grey: #6c7086;
            white: #ffffff;
            light-grey: #cdd6f4;

            width: 600;
            font: " Noto Mono 14";
        }

        element-text, element-icon , mode-switcher {
            background-color: inherit;
            text-color:       inherit;
        }

        window {
            height: 360px;
            border: 3px;
            border-color: #3b3c47;
            border-radius: 12px;
            background-color: rgba(30, 30, 46, 0.9);
        }

        mainbox {
            background-color: rgba(30, 30, 46, 0.0);
            border-radius: 12px;
        }

        inputbar {
            children: [prompt,entry];
            background-color: rgba(30, 30, 46, 0.0);
            border-radius: 12px;
            padding: 2px;
        }

        prompt {
            background-color: @blue;
            padding: 6px;
            text-color: @white;
            border-radius: 8px;
            margin: 20px 0px 0px 20px;
        }

        entry {
            padding: 6px;
            margin: 20px 0px 0px 10px;
            text-color: @fg-col;
            background-color: rgba(30, 30, 46, 0.0);
            border-radius: 8px;
        }

        listview {
            border: 0px 0px 0px;
            padding: 6px 0px 0px;
            margin: 10px 0px 0px 20px;
            columns: 2;
            lines: 5;
            background-color: rgba(30, 30, 46, 0.0);
            border-radius: 8px;
        }

        element {
            padding: 5px;
            background-color: rgba(30, 30, 46, 0.0);
            text-color: @fg-col;
            border-radius: 8px;
        }

        element-icon {
            size: 25px;
        }

        element selected {
            background-color: rgba(30, 30, 46, 0.0);
            text-color: @fg-col2;
            border: 2px;
            border-color: #3b3c47;
            border-radius: 8px;
        }

        mode-switcher {
            spacing: 0;
            border-radius: 8px;
        }

        button {
            padding: 10px;
            background-color: rgba(30, 30, 46, 0.4);
            text-color: @grey;
            vertical-align: 0.5;
            horizontal-align: 0.5;
            border-radius: 8px;
        }

        button selected {
            background-color: rgba(30, 30, 46, 0.4);
            text-color: @light-grey;
            border: 2px;
            border-color: #3b3c47;
            border-radius: 8px;
        }

        message {
            background-color: rgba(30, 30, 46, 0.0);
            margin: 2px;
            padding: 2px;
            border-radius: 8px;
        }

        textbox {
            padding: 6px;
            margin: 20px 0px 0px 20px;
            text-color: @blue;
            background-color: rgba(30, 30, 46, 0.0);
            border-radius: 8px;
        }
    '';
  };
}
