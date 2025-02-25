{ settings, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = settings.system.version;
}
