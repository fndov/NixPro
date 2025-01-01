{ userSettings, ... }: {
  # You should delete ~/.config/* because HM intends to manage it.
  imports = [
    # ../../user/wm/hyprland/hyprland.nix # Window manager.
    # ../../user/software/apps/terminal/alacritty.nix # Terminal.
    ../../user/software/commands/git.nix # Git settings.
    ../../user/software/commands/cli.nix # Command line interface.
    ../../user/software/commands/sh.nix # Shell.
    # ../../user/software/apps/browser/firefox.nix # Browser.
    # ../../user/software/apps/games.nix # Games client.
    # ../../user/software/apps/nautilus.nix # File manager.
    # ../../user/software/apps/virt-manager.nix # Virtual machines.
    # ../../user/software/apps/vscode.nix # Integrated development environment.
  ];
  programs.home-manager.enable = true;
  # home.stateVersion = "24.11"; # Please read the comment before changing.s
  home.stateVersion = "unstable"; # Please read the comment before changing.s
}
