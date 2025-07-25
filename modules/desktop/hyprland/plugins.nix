{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    wayland.windowManager.hyprland.plugins = [
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
      pkgs.hyprlandPlugins.hyprbars
    ];
    wayland.windowManager.hyprland.settings = {
      plugin = {
        hyprbars = {
          bar_height = 29;
          bar_color = "rgb(1e1e2e)";
          "col.text" = "rgb(cdd6f4)";
          bar_text_size = 12;
          bar_text_font = "Inter Bold";
          bar_button_padding = 12;
          bar_padding = 10;
          bar_precedence_over_border = true;
          "hyprbars-button" = [
            "rgb(cb6ba1), 16, , hyprctl dispatch killactive"
            "rgb(6f7cd4), 16, , hyprctl dispatch togglefloating"
            "rgb(aa93d7), 16, , hyprctl dispatch fullscreen 2"
          ];
        };
        dynamic-cursors = {
          mode = "stretch"; # stretch
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
