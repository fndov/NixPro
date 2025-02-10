{ lib, inputs, pkgs, settings, ... }: {
  config = lib.mkMerge [
    /* Commen, here instead of flake.nix for clarity. */
    {
      networking.hostName =
        if settings.profile == "apple"
        then "NixPro-ARM"
        else if settings.profile == "microsoft"
        then "NixPro-WSL"
        else if settings.profile == "server"
        then "NixPro-Server"
        else if settings.profile == "standalone"
        then "NixPro"
        else if settings.profile == "virtual-machine"
        then "NixPro-VM"
        else if settings.profile == "image"
        then "NixPro-Image"
        else "NixPro";

      nix.settings.trusted-users = [ "@wheel" ];
      nix.settings.warn-dirty = false;
      nix.extraOptions = "experimental-features = nix-command flakes";
      
      documentation.enable = lib.mkForce false;
      documentation.doc.enable = lib.mkForce false;
      documentation.info.enable = lib.mkForce false;
      documentation.man.enable = lib.mkForce false;
      documentation.nixos.enable = lib.mkForce false;

      programs.command-not-found.enable = if settings.profile == "image" then false else true;
      programs.nano.enable = builtins.elem settings.profile [ "standalone" "server" ];
      programs.fish.enable = if settings.profile == "microsoft" || settings.user.shell == "fish" then true else false;

      users.users.root.initialPassword = lib.mkForce "password";
      users.mutableUsers = false;
      security.sudo.wheelNeedsPassword = false;
      users.users.${settings.user.name} = {
        isNormalUser = true;
        description = settings.user.name;
        extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
        uid = 1000;
        shell = if settings.profile == "microsoft" || settings.user.shell == "fish" then pkgs.fish else pkgs.bash;
        initialPassword = "password";
      };

      home-manager = {
        users.${settings.user.name} = {
          programs.home-manager.enable = true;
          home.stateVersion = settings.system.version;
        };
        extraSpecialArgs = { inherit inputs settings; };
        useGlobalPkgs = true;
        useUserPackages = false;
        backupFileExtension = "hm-backup";
      };
      system.stateVersion = settings.system.version;
    }

    /* Conditional and DRY profiles. */
    (
      if (settings.profile == "virtual-machine" || settings.profile == "server" || settings.profile == "standalone")
      then {
        boot.loader.grub.useOSProber = true;
        boot.loader.systemd-boot.enable =
          if (settings.system.bootMode == "uefi") then true else false;
        boot.loader.efi.efiSysMountPoint =
          settings.system.bootMountPath; # does nothing if running bios rather than uefi
        boot.loader.efi.canTouchEfiVariables =
          if (settings.system.bootMode == "uefi") then true else false;
        boot.loader.grub.enable =
          if (settings.system.bootMode == "uefi") then false else true;
        boot.loader.grub.device = settings.system.grubDevice;
      }
      else {}
    )
    (
      if (settings.desktop.enable == true || settings.desktop.type == "wm"|| settings.desktop == "hyprland" || settings.profile == "image")
      then {
        home-manager.users.${settings.user.name}.wayland.windowManager.hyprland.settings.exec-once =
        [
          "cp -r /iso/home/${settings.user.name}/${settings.system.flakePath} /home/${settings.user.name}"
          "sudo systemctl restart NetworkManager"
          "${settings.user.terminal} -e 'sleep 1;nmtui'"
          "sudo rm -rf /home/nixos/"
          "sudo nixos-generate-config && cp /etc/nixos/hardware.nix /iso/home/${settings.user.name}/${settings.system.flakePath} && cp /etc/nixos/hardware.nix /home/${settings.user.name}/${settings.system.flakePath}/system/driver/hardware.nix"
          "notify-send 'Welcome to Hyprland by NixPro!'" 
        ];
      }
      else {}
    )

    /* Flake settings. */
    (lib.mkIf settings.system.automation {
      system.autoUpgrade = {
        enable = true;
        flake = inputs.self.outPath;
        flags = [ "--update-input" "nixpkgs" "-L" ];
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
      # boot.kernelPackages = pkgs.linuxPackages_hardened;
      
      boot.kernelParams = [
        # Don't merge slabs
        "slab_nomerge"

        # Overwrite free'd pages
        "page_poison=1"

        # Enable page allocator randomization
        "page_alloc.shuffle=1"
        
        # Disable debugfs
        "debugfs=off"
      ];

      security = {
        auditd.enable = true;
        audit.enable = true;
        protectKernelImage = true;
        lockKernelModules = true;
      };
      networking.firewall.enable = true;
    })

    (lib.mkIf settings.system.sshd {
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
          PasswordAuthentication = true;
          UseDns = true;
        };
      };
    })

    (lib.mkIf settings.system.networking {
      environment.systemPackages = [ pkgs.networkmanager ];

      networking.wireless.enable = if settings.profile == "image" then lib.mkForce false else false;
      
      networking.networkmanager.enable = true;
      services = {
        udev.packages = [ pkgs.networkmanager ];
        dbus.enable = true;
        resolved.enable = true;
      };
    })

    (lib.mkIf settings.system.timezone {
      time.timeZone = "America/Chicago";
      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };
    })
  ];
}
