{ lib, pkgs, settings, ... }: let
  isMicrosoftFish = (settings.profile == "microsoft") && (settings.user.shell == "fish"); 
in {
  /* Commen */
  networking.hostName = 
  if settings.profile == "apple" then "NixPro-ARM"
  else if settings.profile == "microsoft" then "NixPro-WSL" 
  else if settings.profile == "server" then "NixPro-Server" 
  else if settings.profile == "standalone" then "NixPro" 
  else if settings.profile == "virtual-machine" then "NixPro-VM"
  else if settings.profile == "image" then "NixPro-Image"
  else "NixPro";
  nix.settings.trusted-users = [ "@wheel" ];
  nix.extraOptions = "experimental-features = nix-command flakes";

  /* Account. */
  users.users.root = 
    if settings.profile == "image" then {
      initialPassword = "password";
      # initialHashedPassword = lib.mkForce null;
      # hashedPassword = null;
      # password = null;
      # hashedPasswordFile = null;
    } else {
      initialPassword = "password";
    };

  users.users.${settings.user.name} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
    uid = 1000;
    shell = lib.mkIf isMicrosoftFish pkgs.fish;
    initialPassword = "password";
  };
  programs.fish.enable = lib.mkIf isMicrosoftFish true;
  security.sudo.wheelNeedsPassword = false; 

  /* NixPro Settings. */
  config = lib.mkMerge [
    (lib.mkIf settings.system.automation {
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
    })
    
    (lib.mkIf settings.system.security {
      security = {
        auditd.enable = false;
        audit.enable = false;
        # apparmor.enable = false;
        # apparmor.killUnconfinedConfinables = false;
        # forcePageTableIsolation = false;
        # lockKernelModules = false;
        protectKernelImage = true;
      };
      networking.firewall.enable = true;
      };
    })
    
    (lib.mkIf settings.system.sshd {
      services.openssh = {
        enable = true;
         ports = [ 22 ];
         settings = {
          PasswordAuthentication = true;
          UseDns = true;
          X11Forwarding = true;
          PermitRootLogin = "yes";
        };
      };
    })
    
    (lib.mkIf settings..enable {

    })
    
    (lib.mkIf settings..enable {

    })
    
    (lib.mkIf settings..enable {

    })
    
    (lib.mkIf settings..enable {

    })
    
  ];
}
