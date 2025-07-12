{ settings, ... }:
  { home-manager.users.${settings.account.name} = { ... }: let
    animationSpeed = settings.desktop.animationSpeed;
    animationDuration = if animationSpeed == "slow" then "4"
    else if animationSpeed == "medium" then "2.5"
    else "1.5";
    borderDuration = if animationSpeed == "slow" then "10"
    else if animationSpeed == "medium" then "6"
    else "3";
  in {
    wayland.windowManager.hyprland.settings = {
      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
          "smoothFocus, 0.1, 0.8, 0.1, 1.0"
        ];

        animation = [
          # Windows
          "windows, 1, ${animationDuration}, overshot, slide"
          "windowsIn, 1, ${animationDuration}, easeOutExpo, slide"
          "windowsOut, 1, ${animationDuration}, easeOutCirc, slide"
          # "windowsMove, 1, ${animationDuration}, easeInOutCirc"

          # Enhanced focus changes
          "fade, 1, ${animationDuration}, smoothFocus"
          "fadeIn, 1, ${animationDuration}, smoothFocus"
          "fadeOut, 1, ${animationDuration}, smoothFocus"
          "fadeSwitch, 1, ${animationDuration}, smoothFocus"
          "fadeShadow, 1, ${animationDuration}, smoothFocus"
          "fadeDim, 1, ${animationDuration}, smoothFocus"

          # Borders (kept subtle for focus changes)
          "border, 1, ${borderDuration}, smoothFocus"
          "borderangle, 1, ${borderDuration}, easeInOutCirc, loop"

          # Layers
          "layers, 1, ${animationDuration}, overshot, slide"
          "layersIn, 1, ${animationDuration}, easeOutExpo, slidefade"
          "layersOut, 1, ${animationDuration}, easeOutCirc, slidefade"

          # Layer fading
          "fadeLayers, 1, ${animationDuration}, smoothFocus"
          "fadeLayersIn, 1, ${animationDuration}, smoothFocus"
          "fadeLayersOut, 1, ${animationDuration}, smoothFocus"

          # Workspaces - horizontal sliding
          "workspaces, 1, ${animationDuration}, overshot, slide"
          "workspacesIn, 1, ${animationDuration}, easeOutExpo, slide"
          "workspacesOut, 1, ${animationDuration}, easeOutCirc, slide"

          # Special workspaces
          "specialWorkspace, 1, ${animationDuration}, crazyshot, slidevert"
          "specialWorkspaceIn, 1, ${animationDuration}, easeOutExpo, slidevert"
          "specialWorkspaceOut, 1, ${animationDuration}, easeOutCirc, slidevert"
        ];
      };
    };
  };
}
