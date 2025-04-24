{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    wayland.windowManager.hyprland = {
      plugins = [
        pkgs.hyprlandPlugins.hypr-dynamic-cursors
      ];
      settings = {
        plugin.dynamic-cursors = {
          mode = "tilt"; # stretch
          threshold = "2";
          shake = {
            threshold = 4;
            base = 1;
            speed = 2;
            influence = 2;
            limit = 2;
            timeout = 300;
          };
        };
      };
    };
  };
}
