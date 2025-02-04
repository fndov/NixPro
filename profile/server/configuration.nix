{ inputs, settings, ... }: {
  imports = [ /* Configuration */
    ../../system/security/extra.nix
    ../../system/security/firewall.nix
    ../../system/security/timezone.nix
  ];
  # networking.wireless.enable = false;
  networking.networkmanager.enable = true; 

  system.stateVersion = settings.system.version;
}
