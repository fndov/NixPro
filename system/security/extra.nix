{ pkgs, inputs, ... }:{
  /* Enable printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  environment.systemPackages = [ pkgs.cups-filters ]; */
  
  security = {
    auditd.enable = false;
    audit.enable = false;
    # apparmor.enable = false;
    # apparmor.killUnconfinedConfinables = false;
    # forcePageTableIsolation = false;
    # lockKernelModules = false;
    protectKernelImage = true;
  };
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      sandbox = true;
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
}
