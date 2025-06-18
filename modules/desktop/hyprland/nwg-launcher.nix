{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      nwg-launchers
      gtk4-layer-shell
      (writeShellScriptBin "overview-script" ''
        nice -21 nwggrid -o 0.8 -b 0000001 -n 8 -s 96 -layer-shell-exclusive-zone -1 -c ~/.config/nwg/overview.css
      '')
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "nwggrid-server"
    ];
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER,Space,exec,overview-script"
    ];
    home.file.".config/nwg/overview.css".text = ''
      window {
        background-color: rgba(30, 30, 46, 0.15);
      }
      button {
        background-color: rgba(49, 50, 68, 0.4);
        border-radius: 20px;
        border: 2px solid rgba(205, 214, 244, 0.35);
        color: #cdd6f4;
        font-family: "Inter", "Noto Sans", sans-serif;
        font-size: 16pt;
        font-weight: 500;
        padding: 12px 20px;
        margin: 10px;
        transition: background-color 0.15s ease, border-color 0.15s ease, color 0.15s ease;
        box-shadow: 0 2px 12px rgba(205, 214, 244, 0.08);
      }
      button:hover {
        background-color: rgba(205, 214, 244, 0.15);
        border-color: #f5c2e7;
        color: #f5c2e7;
      }
      label {
        color: #cdd6f4;
        font-size: 14pt;
      }
      .grid {
        padding: 24px;
      }
    '';
  };
}
