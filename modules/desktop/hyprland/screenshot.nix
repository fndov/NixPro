{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; };
  in {
    home.packages = with pkgs; [
      (writeShellScriptBin "screenshot" ''
        FILE=~/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
        grim -c "$FILE" && wl-copy < "$FILE" && notify-send "Saved to clipboard" "$FILE"
      '')
      (writeShellScriptBin "screenshot-snippet" ''
        FILE=~/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
        SELECTION=$(slurp -b "#00000000" -c "#00000000" -s "#00000000") || exit 1
        sleep 1
        grim -c -g "$SELECTION" "$FILE" && wl-copy < "$FILE" && notify-send "Saved to clipboard" "$FILE"
      '')
      unstable.grim
      unstable.slurp
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "mkdir -p ~/Media/Pictures/Screenshots"
    ];
    wayland.windowManager.hyprland.settings.bind = [
      ''SUPER,Print,exec,screenshot''
      '',Print,exec,screenshot-snippet''
    ];
  };
}
