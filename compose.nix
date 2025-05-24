{ config, lib, inputs, pkgs, settings, ... }: let unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; }; in {
  config = lib.mkMerge [
    {
      networking.hostName =
      if settings.profile == "darwin"
      then "NixPro-ARM"
      else if settings.profile == "windows-subsystem"
      then "NixPro-WSL"
      else if settings.profile == "server"
      then "NixPro-Server"
      else if settings.profile == "workstation"
      then "NixPro"
      else if settings.profile == "virtual-machine"
      then "NixPro-VM"
      else if settings.profile == "image"
      then "NixPro-Image"
      else "NixPro";
      time.timeZone = "America/Chicago";
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_ADDRESS = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_IDENTIFICATION = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_MEASUREMENT = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_MONETARY = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_NAME = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_NUMERIC = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_PAPER = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_TELEPHONE = "en_US.UTF-8";
      i18n.extraLocaleSettings.LC_TIME = "en_US.UTF-8";
      documentation.enable = lib.mkForce false;
      documentation.doc.enable = lib.mkForce false;
      documentation.info.enable = lib.mkForce false;
      documentation.nixos.enable = lib.mkForce false;
      environment.sessionVariables = {
        NIX_AUTO_RUN = "1";
        NIXPKGS_ALLOW_UNFREE = "1";
      };
      nix.extraOptions = "experimental-features = nix-command flakes";
      nix.settings.sandbox = true;
      nix.settings.trusted-users = [ "@wheel" ];
      nix.settings.warn-dirty = false;
      nix.settings.substituters = [
        # "https://cache.lix.systems"
        "https://hyprland.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        # "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      nix.settings.auto-optimise-store = true;
      nix.optimise.automatic = true;
      nix.optimise.dates = [ "weekly" ];
      nix.gc.automatic = true;
      nix.gc.dates = "weekly";
      nix.gc.options = "--delete-older-than 30d";
      home-manager.useUserPackages = false;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.useGlobalPkgs = false;
      home-manager.users.${settings.account.name} = {
        programs.home-manager.enable = true;
        home.stateVersion = settings.system.version;
      };
      environment.systemPackages = with pkgs; [
        networkmanagerapplet
        ifuse
      ] ++ (if settings.account.editor == "micro" then [ micro ] else [])
        ++ (if settings.account.editor == "flow" then [ unstable.flow-control ] else []);
      services.usbmuxd.enable = true;
      services.usbmuxd.package = pkgs.usbmuxd2;
      services.preload.enable = true;
      services.gpm.enable = true;
      programs.command-not-found.enable = if settings.profile == "image" then false else true;
      programs.nano.enable = false;
      programs.fish.enable = if settings.account.shell == "fish" then true else false;
      system.stateVersion = settings.system.version;
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.coredump.extraConfig = ''
        [Coredump]
        Storage=none
        ProcessSizeMax=0
      '';
      hardware.ksm.enable = true;
      hardware.ksm.sleep = 1;
      security.sudo.wheelNeedsPassword = false;
      users.mutableUsers = false;
      users.users.root.hashedPassword = lib.mkForce settings.account.password;
      users.users.${settings.account.name} = {
        isNormalUser = true;
        hashedPassword = settings.account.password;
        description = settings.account.name;
        extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
        uid = 1000;
        shell = if settings.profile == "windows-subsystem" || settings.account.shell == "fish" then pkgs.fish else pkgs.bash;
      };
      services.zram-generator.enable = builtins.elem settings.profile [ "image" "workstation" "virtual-machine" "server" ];
      services.zram-generator.settings.zram0.zram-size = "ram * 2";
      services.zram-generator.settings.zram0.compression-algorithm = "zstd"; # "zstd lz4 (type=huge)";
      services.zram-generator.settings.zram0.fs-type = "swap";
      services.zram-generator.settings.zram0.swap-priority = 3;
      boot.kernel.sysctl."vm.swappiness" = 180; # 60
      boot.kernel.sysctl."vm.dirty_background_ratio" = 100; # 10
      boot.kernel.sysctl."vm.dirty_ratio" = if settings.profile == "image" then 80 else 100; # 20
      boot.kernel.sysctl."vm.vfs_cache_pressure" = 1; # 100
      boot.kernel.sysctl."vm.min_free_kbytes" = 1000; # 1000
      boot.kernel.sysctl."vm.compaction_proactiveness" = 100; # 20
      boot.kernel.sysctl."vm.page-cluster" = 0;
      boot.kernel.sysctl."vm.watermark_boost_factor" = 0;
      boot.kernel.sysctl."vm.watermark_scale_factor" = 125;
      boot.tmp.useTmpfs = true;
      boot.initrd.compressor = "zstd";
      boot.initrd.compressorArgs = [ "-15" ];
      boot.initrd.verbose = true;
      services.earlyoom.enable = builtins.elem settings.profile [ "image" ];
      services.earlyoom.enableNotifications = true;
      services.earlyoom.freeMemThreshold = 3;
      services.earlyoom.freeMemKillThreshold = 3;
      services.earlyoom.freeSwapThreshold = 3;
      services.earlyoom.freeSwapKillThreshold = 3;
      boot.kernelPackages = # xanmod xanmod_latest rt rt_latest hardened zen
      (if settings.profile == "image"
        then pkgs.linuxPackages_latest
        else
        (if settings.profile == "server"
          then pkgs.linuxPackages
          else
          (if settings.profile == "workstation"
            then pkgs.linuxPackages_xanmod
            else
            (if settings.profile == "windows-subsystem"
              then pkgs.linuxPackages
              else
              (if settings.profile == "virtual-machine"
                then pkgs.linuxPackages
                else null)))));
      boot.readOnlyNixStore = true;
      boot.blacklistedKernelModules = [ "nouveau" ];
      boot.kernelParams = [
        "splash"
        "quiet"
        "rd.systemd.show_status=false"
        "udev.log_level=0"
        "rd.udev.log_level=0"
        "udev.log_priority=0"
        "fastboot"
        "mitigations=off"
        "noibrs"
        "noibpb"
        "nopti"
        "nospectre_v1"
        "nospectre_v2"
        "l1tf=off"
        "nospec_store_bypass_disable"
        "no_stf_barrier"
        "mds=off"
        "tsx=on"
        "tsx_async_abort=off"
        "nowatchdog"
        "panic=1"
        "boot.panic_on_fail"
        "transparent_hugepage=always"
        "init_on_alloc=0"
        "init_on_free=0"
        "idle=nomwait"
        "ascpi_osi=Linux"
        "preempt=full"
        "uinput"
      ];
    }
    (if (settings.profile == "image") then {
      boot.kernelPatches = [
        # {patch = ./kernel-patches/tkg-6.14/0001-bore.patch;}
        # {patch = ./kernel-patches/tkg-6.14/0009-glitched-bmq.patch;}
        # {patch = ./kernel-patches/tkg-6.14/0012-misc-additions.patch;}
        # {patch = ./kernel-patches/tkg-6.14/0013-optimize_harder_O3.patch;}
        # {patch = ./kernel-patches/tkg-6.14/0014-OpenRGB.patch;}
      ];
    } else {})
    (if (settings.profile == "virtual-machine" || settings.profile == "server" || settings.profile == "workstation") then {
      boot.consoleLogLevel = 0;
      boot.tmp.cleanOnBoot = true;
      boot.loader.systemd-boot.enable = if (settings.system.bootMode == "uefi") then true else false;
      boot.loader.systemd-boot.editor = false;
      boot.loader.systemd-boot.configurationLimit = 25;
      boot.loader.grub.enable = if (settings.system.bootMode == "uefi") then false else true;
      boot.loader.grub.useOSProber = true;
      boot.loader.grub.device = settings.system.grubDevice;
      boot.loader.grub.devices = [ settings.system.grubDevice ];
      boot.loader.efi.efiSysMountPoint = settings.system.bootMountPath;
      boot.loader.efi.canTouchEfiVariables = if (settings.system.bootMode == "uefi") then true else false;
      systemd.network.wait-online.enable = false;
    } else {})
    (if settings.driver.graphics == "nvidia" then {
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = [ pkgs.nvtopPackages.full ];
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest; /* production or latest */
      # ^ Works best with boot.kernelPackages = pkgs.linuxPackages;
      hardware.nvidia.powerManagement.enable = true;
      hardware.nvidia.powerManagement.finegrained = true;
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.nvidiaSettings = false;
      hardware.nvidia.open = false;
      boot.blacklistedKernelModules = [ "nouveau" ];
      boot.kernelParams = [
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia-drm.fbdev=1"
        "nvidia"
      ];
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;
      hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
      hardware.nvidia.prime.nvidiaBusId = "PCI:9:0:0";
      hardware.nvidia.prime.offload.enable = true;
      hardware.nvidia.prime.offload.enableOffloadCmd = true;
    } else {})
    (if settings.driver.graphics == "amd" then {
    } else {})
    (if settings.driver.graphics == "intel" then {
      services.xserver.videoDrivers = [ "i915" ];
      boot.initrd.kernelModules = [ "i915" ];
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;
    } else {})
    (lib.mkIf (settings.system.automation && settings.profile != "microsoft") {
      system.autoUpgrade.enable = true;
      system.autoUpgrade.flake = inputs.self.outPath;
      system.autoUpgrade.flags = [ "nixpkgs" "-L" ];
      system.autoUpgrade.dates = "02:00";
      system.autoUpgrade.randomizedDelaySec = "45min";
    })
    (lib.mkIf settings.system.security {
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_hardened;
      boot.kernelParams = [
        "slab_nomerge"
        "page_poison=1"
        "page_alloc.shuffle=1"
        "debugfs=off"
      ];
      security.lockKernelModules = true;
      security.auditd.enable = true;
      security.audit.enable = true;
      security.protectKernelImage = true;
      networking.firewall.enable = true;
    })
    (lib.mkIf settings.system.sshd {
      services.openssh.enable = true;
      services.openssh.ports = [ 22 ];
      services.openssh.settings.PasswordAuthentication = true;
      services.openssh.settings.UseDns = true;
      services.openssh.permitRootLogin = "yes";
    })
    (lib.mkIf (settings.profile != "microsoft") {
      environment.systemPackages = [ pkgs.networkmanager ];
      networking.networkmanager.enable = true;
      networking.wireless.enable = if settings.profile == "image" then lib.mkForce false else false;
      services.udev.packages = [ pkgs.networkmanager ];
      services.dbus.enable = true;
      services.resolved.enable = true;
    })
  ];
}
