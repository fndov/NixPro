{ userSettings, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Essential:
    lutris
    heroic
    mangohud
    authenticator
    swayimg
    nautilus
    vlc
    vscode
    baobab
    blender
    chatterino2
    godot_4
    kcalc
    kdenlive
    krita
    obs-studio
    telegram-desktop
    kwrited
    obsidian
    zed-editor
    gimp
    ffmpeg
    lollypop
    # kdenlive
  ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  # wayland.windowManager.hyprland.settings.exec-once = [
  #   "[workspace 1 silent] ${userSettings.terminal}"
  #   "[workspace 2 silent] firefox"
  #   "[workspace 3 silent] zeditor"
  # ];
}
