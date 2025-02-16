{ inputs, settings, pkgs, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = settings.system.version;  
}
