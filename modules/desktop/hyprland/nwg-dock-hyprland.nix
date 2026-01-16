{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; };
  in {
    home.packages = [
      pkgs.nwg-dock-hyprland
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "nice -1 nwg-dock-hyprland -i 60 -x -nolauncher"
    ];
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER,D,exec,pgrep nwg-dock > /dev/null && pkill nwg-dock || nwg-dock-hyprland -i 60 -x -nolauncher &"
    ];
    home.file.".config/nwg-dock-hyprland/style.css".text = ''
    * {
      transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
    }

    window {
      background: #1e1e2e;
      border-radius: 10px;
      border-style: none;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    }

    #box {
      padding: 4px;
      border-radius: 10px;
    }

    #active {
      background-color: #313244;
      border-radius: 8px;
      transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
    }

    button, image {
      background: none;
      border-style: none;
      box-shadow: none;
      color: #cdd6f4;
      transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
    }

    button {
      padding: 4px;
      margin: 2px;
      color: #cdd6f4;
      font-size: 12px;
      border-radius: 8px;
      outline: none;
      transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
    }

    button:hover {
      background-color: rgba(49, 50, 68, 0.6);
      border-radius: 8px;
    }

    button:focus {
      box-shadow: none;
      outline: none;
    }

    .workspace-dot {
      background-color: #3b3c47;
      border-radius: 50%;
      transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
    }

    .workspace-dot.active {
      background-color: #3b3c47;
    }

    .workspace-dot.inactive {
      background-color: rgba(59, 60, 71, 0.5);
    }

    tooltip, .tooltip, #tooltip, popover, .popover {
      opacity: 0;
      background: transparent;
      transition: none;
      border: none;
      box-shadow: none;
    }
    '';
  };
}
