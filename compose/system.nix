{ config, lib, inputs, pkgs, settings, ... }: {
  config = lib.mkMerge [
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

      documentation.enable = lib.mkForce false;
      documentation.doc.enable = lib.mkForce false;
      documentation.info.enable = lib.mkForce false;
      documentation.man.enable = lib.mkForce false;
      documentation.nixos.enable = lib.mkForce false;
      nix.extraOptions = "experimental-features = nix-command flakes";
      nix.settings.sandbox = true;
      nix.settings.trusted-users = [ "@wheel" ];
      nix.settings.warn-dirty = false;
      nix.settings.substituters = [ "https://cache.lix.systems" ];
      nix.settings.trusted-public-keys = [ "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o=" ];
      nix.settings.auto-optimise-store = true;
      nix.optimise.automatic = true;
      nix.optimise.dates = [ "weekly" ];
      nix.gc.automatic = true;
      nix.gc.dates = "weekly";
      nix.gc.options = "--delete-older-than 30d";
      home-manager.useGlobalPkgs = false;
      home-manager.useUserPackages = false;
      home-manager.backupFileExtension = "hm-backup";
      programs.command-not-found.enable = if settings.profile == "image" then false else true;
      programs.nano.enable = false;
      services.gpm.enable = true;
      programs.fish.enable = if settings.user.shell == "fish" then true else false;
      environment.systemPackages = [ pkgs.micro ];
      boot.initrd.compressor = "zstd";
      boot.initrd.compressorArgs = [ "-19" ];
      system.stateVersion = settings.system.version;
      systemd.services.NetworkManager-wait-online.enable = false;
      hardware.ksm.enable = true;
      hardware.ksm.sleep = 1;

      users.mutableUsers = false;
      users.users.root.initialPassword = lib.mkForce settings.user.password;
      security.sudo.wheelNeedsPassword = false;
      users.users.${settings.user.name} = {
        isNormalUser = true;
        initialPassword = settings.user.password;
        description = settings.user.name;
        extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
        uid = 1000;
        shell = if settings.profile == "microsoft" || settings.user.shell == "fish" then pkgs.fish else pkgs.bash;
      };

      zramSwap.enable = builtins.elem settings.profile [ "image" "standalone" "virtual-machine" "server" ];
      zramSwap.memoryPercent = 100; # 30
      zramSwap.algorithm = "zstd -Xcompression-level 22"; # lzo is small, zstd is fast.
      zramSwap.priority = 3;
      boot.kernel.sysctl = {
        "vm.swappiness" = 200; # 60
        "vm.dirty_background_ratio" = 80; # 10
        "vm.dirty_ratio" = if settings.profile == "image" then 3 else 90; # 20
        "vm.vfs_cache_pressure" = 0; # 100
        "vm.min_free_kbytes" = 1000; # 0
        "vm.compaction_proactiveness" = 50; # 20
      };
      services.earlyoom = {
        enable = if settings.profile == "image" then true else false;
        enableNotifications = true;
        freeMemThreshold = 3;
        freeMemKillThreshold = 3;
        freeSwapThreshold = 3;
        freeSwapKillThreshold = 3;
      };

      boot.kernelPackages =
        (if settings.profile == "image"
          then pkgs.linuxPackages_xanmod_latest
        else
          (if settings.profile == "server"
            then pkgs.linuxPackages
          else
            (if settings.profile == "standalone"
              then pkgs.linuxPackages
            else
              (if settings.profile == "microsoft"
                then pkgs.linuxPackages
              else
                (if settings.profile == "virtual-machine"
                  then pkgs.linuxPackages_latest
                else null)))));

      boot.blacklistedKernelModules = [ "nouveau" ];

      boot.kernelParams = [
        "quiet"
        "rd.systemd.show_status=false"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "fastboot"
        "mitigations=off"
        "noibrs"
        "noibpb"
        "nopti"
        "nospectre_v2"
        "nospectre_v1"
        "nowatchdog"
        "l1tf=off"
        "nospec_store_bypass_disable"
        "no_stf_barrier"
        "mds=off"
        "tsx=on"
        "tsx_async_abort=off"
        "panic=1"
        "boot.panic_on_fail"
        "transparent_hugepage=always"
        "init_on_alloc=0"
        "init_on_free=0"
        "idle=nomwait"
        "ascpi_osi=Linux"
        "preempt=full"
        "noatime"
        /*
          "nodiratime"
          "nofail"
          "x-systemd.device-timeout=5s"
          "splash"
          "rd.systemd.show_status=0"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
          "intel_pstate=active"
          "processor.max_cstate=1"
          "intel_idle.max_cstate=1"
          "threadirqs"
          "i915.fastboot=1"
          "raid=noautodetect"
          "noapic"
        */
      ];
    }
    (if (settings.profile == "virtual-machine" || settings.profile == "server" || settings.profile == "standalone")
      then {
        boot.loader.grub.useOSProber = true;
        boot.loader.systemd-boot.editor = false;
        systemd.network.wait-online.enable = false;
        boot.consoleLogLevel = 3;
        boot.tmp.cleanOnBoot = true;
        boot.loader.systemd-boot.enable =
          if (settings.system.bootMode == "uefi") then true else false;
        boot.loader.efi.efiSysMountPoint =
          settings.system.bootMountPath;
        boot.loader.efi.canTouchEfiVariables =
          if (settings.system.bootMode == "uefi") then true else false;
        boot.loader.grub.enable =
          if (settings.system.bootMode == "uefi") then false else true;
        boot.loader.grub.device = settings.system.grubDevice;
      }
      else {})
    (if (settings.desktop.type == "hyprland" && settings.profile == "image")
      then {
        home-manager.users.${settings.user.name}.wayland.windowManager.hyprland.settings.exec-once = [
          "cp -r /iso/home/${settings.user.name}/${settings.system.flakePath} /home/${settings.user.name}; chown -R miyu /home/${settings.user.name}/${settings.system.flakePath}; chmod -R 777 /home/${settings.user.name}/${settings.system.flakePath}"
          "sudo systemctl restart NetworkManager"
          "${settings.user.terminal} -e 'sleep 1;nmtui'"
          "sudo rm -rf /home/nixos/"
          "sudo nixos-generate-config && cp /etc/nixos/hardware.nix /home/${settings.user.name}/${settings.system.flakePath}/modules/system/"
          "notify-send 'Welcome to Hyprland by NixPro!'"
        ];
      }
      else {})
    (if (settings.desktop.type == "hyprland" && settings.profile == "virtual-machine")
      then {
        home-manager.users.${settings.user.name} = {
          wayland.windowManager.hyprland.settings.monitor = "Virtual-1, 1920x1080, 0x0, 1";
        };
      }
      else {})
    (if settings.driver.graphics == "nvidia"
      then {
        nixpkgs.config.allowUnfree = true;
        environment.systemPackages = [ pkgs.nvtopPackages.full ];
        boot.blacklistedKernelModules = [ "nouveau" ];
        services.xserver.videoDrivers = [ "nvidia" ];
        boot.kernelParams = [
          "nvidia_drm"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia-drm.fbdev=1"
          "nvidia"
        ];
        hardware.nvidia = {
          package = config.boot.kernelPackages.nvidiaPackages.latest;
          # ^ Works best with `boot.kernelPackages = pkgs.linuxPackages;`
          powerManagement.enable = true;
          powerManagement.finegrained = true;
          modesetting.enable = true;
          nvidiaSettings = false;
          open = false;
        };
        hardware.nvidia.prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:9:0:0";
          offload.enable = true;
          offload.enableOffloadCmd = true;
        };
      }
      else {})
    (if settings.driver.graphics == "amd"
      then {
      }
      else {})
    (if settings.driver.graphics == "intel"
      then {
      }
      else {})
    (lib.mkIf (settings.system.automation && settings.profile != "microsoft") {
      system.autoUpgrade = {
        enable = true;
        flake = inputs.self.outPath;
        flags = [ "--update-input" "nixpkgs" "-L" ];
        dates = "02:00";
        randomizedDelaySec = "45min";
      };
    })
    (lib.mkIf settings.system.security {
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_hardened;
      boot.kernelParams = [
        "slab_nomerge"
        "page_poison=1"
        "page_alloc.shuffle=1"
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
    (lib.mkIf settings.system.printing {
      services.printing.enable = true;
      services.avahi.enable = true;
      services.avahi.nssmdns4 = true;
      services.avahi.openFirewall = true;
      environment.systemPackages = [ pkgs.cups-filters ];
    })
    (lib.mkIf settings.driver.bluetooth {
      hardware.bluetooth.enable = true;
      services.blueman.enable = true;
    })
    (lib.mkIf (settings.driver.networking && settings.profile != "microsoft") {
      environment.systemPackages = [ pkgs.networkmanager ];
      networking.networkmanager.enable = true;
      networking.wireless.enable = if settings.profile == "image" then lib.mkForce false else false;
      services.udev.packages = [ pkgs.networkmanager ];
      services.dbus.enable = true;
      services.resolved.enable = true;
    })
    (lib.mkIf settings.driver.usbmuxd {
      services.usbmuxd.enable = true;
      services.usbmuxd.package = pkgs.usbmuxd2;
      environment.systemPackages = with pkgs; [ networkmanagerapplet ifuse ];
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
