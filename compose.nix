{ config, lib, inputs, pkgs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; };
in {
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

      networking.firewall.enable = true;

      time.timeZone = settings.timezone;

      documentation.enable = lib.mkForce false;
      documentation.man.enable = lib.mkForce false;
      documentation.doc.enable = lib.mkForce false;
      documentation.info.enable = lib.mkForce false;
      documentation.nixos.enable = lib.mkForce false;

      environment.sessionVariables.NIX_AUTO_RUN = "1";
      environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

      environment.systemPackages = with pkgs; [
        # inputs.nix-software-center.packages.${system}.nix-software-center
        ifuse
      ] ++ (if settings.account.editor == "micro" then [ micro ] else [])
        ++ (if settings.account.editor == "nano" then [ nano ] else [])
        ++ (if settings.account.editor == "doom" then [ emacs ] else [])
        ++ (if settings.account.editor == "flow" then [ unstable.flow-control ] else []);

      nix.extraOptions = "experimental-features = nix-command flakes";
      nix.settings.sandbox = true;
      nix.settings.download-buffer-size = 3221225472; # 256MB buffer to avoid "buffer full" warnings
      nix.settings.warn-dirty = false;
      nix.settings.trusted-users = [ "@wheel" ];
      nix.settings.allowed-users = [ "${settings.account.name}" ];

      nix.settings.substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        # "https://cache.lix.systems"
        # "https://hyprland.cachix.org"
        # "https://chaotic-nyx.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
      ];
      nix.settings.auto-optimise-store = true;
      nix.optimise.automatic = true;
      nix.optimise.dates = [ "weekly" ];
      nix.gc.automatic = true;
      nix.gc.dates = "weekly";
      nix.gc.options = "--delete-older-than 30d";

      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = false;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.users.${settings.account.name} = {
        programs.home-manager.enable = true;
        home.stateVersion = settings.system.version;
      };

      programs.fish.enable = if settings.account.shell == "fish" then true else false;
      programs.zsh.enable = if settings.account.shell == "zsh" then true else false;
      programs.nano.enable = if settings.account.editor == "nano" then true else false;
      services.emacs.enable = if settings.account.editor == "doom" then true else false;
      programs.command-not-found.enable = if settings.profile == "image" then false else true;

      hardware.ksm.enable = true;
      hardware.ksm.sleep = 60;

      security.sudo.wheelNeedsPassword = false;

      users.mutableUsers = false;
      users.users.root.hashedPassword = lib.mkForce settings.account.password;
      users.users.root.isSystemUser = true;
      users.users.${settings.account.name} = {
        isNormalUser = true;
        hashedPassword = settings.account.password;
        description = settings.account.name;
        extraGroups = [
          "networkmanager"
          "wheel"
          "qemu-libvirtd"
          "libvirtd"
          "kvm"
          "docker"
          "cdrom"
        ];
        uid = 1000;
        shell = if settings.account.shell == "zsh" then pkgs.zsh
          else if settings.account.shell == "fish" then pkgs.fish
          else if settings.account.shell == "nushell" then pkgs.nushell
        else pkgs.bash;
      };

      services.zram-generator.enable = builtins.elem settings.profile [ "image" "workstation" "virtual-machine" "server" ];
      services.zram-generator.settings.zram0.zram-size = "ram * 2";
      services.zram-generator.settings.zram0.compression-algorithm = "zstd"; # "zstd lz4 (type=huge)";
      services.zram-generator.settings.zram0.fs-type = "swap";
      services.zram-generator.settings.zram0.swap-priority = 3;

      services.earlyoom.enable = builtins.elem settings.profile [ "image" ];
      services.earlyoom.enableNotifications = true;
      services.earlyoom.freeMemThreshold = 3;
      services.earlyoom.freeMemKillThreshold = 3;
      services.earlyoom.freeSwapThreshold = 3;
      services.earlyoom.freeSwapKillThreshold = 3;

      system.stateVersion = settings.system.version;
      system.nixos.tags = [ settings.system.tag ];
    }
    (if settings.system.init == "systemd-boot" then {
      boot.consoleLogLevel = 0;
      boot.tmp.cleanOnBoot = false;
      boot.tmp.useTmpfs = true;
      boot.initrd.compressor = "zstd";
      boot.initrd.compressorArgs = [ "-15" ];
      boot.initrd.verbose = true;
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
      systemd.services.NetworkManager-wait-online.enable = false;
    } else {})
    (if settings.system.init == "limine" then {
      boot.loader.systemd-boot.enable = false;

      boot.loader.limine.enable = true;
      boot.loader.limine.efiSupport = if (settings.system.bootMode == "uefi") then true else false;
      boot.loader.limine.style.wallpapers = [ ./boot-screen.jpg ];
      boot.loader.limine.style.interface.resolution = "1920x1080";
      boot.loader.limine.style.interface.branding = "NixPro";

      boot.loader.grub.enable = false;
      boot.loader.grub.device = settings.system.grubDevice;
      boot.loader.grub.devices = [ settings.system.grubDevice ];
      boot.loader.efi.efiSysMountPoint = settings.system.bootMountPath;
      boot.loader.efi.canTouchEfiVariables = if (settings.system.bootMode == "uefi") then true else false;

      boot.readOnlyNixStore = true;
      boot.consoleLogLevel = 0;
      boot.tmp.cleanOnBoot = false;
      boot.tmp.useTmpfs = true;
      boot.initrd.compressor = "zstd";
      boot.initrd.compressorArgs = [ "-15" ];
      boot.initrd.verbose = true;

      systemd.network.wait-online.enable = false;
      systemd.services.NetworkManager-wait-online.enable = false;
    } else {})
    (if settings.driver.graphics == "nvidia" then {
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = [ pkgs.nvtopPackages.full ];
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production; /* production or latest */
      # ^ Works best with boot.kernelPackages = pkgs.linuxPackages;
      hardware.nvidia.powerManagement.enable = true;
      hardware.nvidia.powerManagement.finegrained = true;
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.nvidiaSettings = true;
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
      hardware.nvidia.prime.intelBusId = settings.driver.intelBusID;
      hardware.nvidia.prime.nvidiaBusId = settings.driver.nvidiaBusID;
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
    (lib.mkIf (settings.system.automation && settings.profile != "windows-subsystem") {
      system.autoUpgrade.enable = true;
      system.autoUpgrade.allowReboot = false; # Reboots in order to upgrade after a kernel update.
      system.autoUpgrade.flake = inputs.self.outPath;
      system.autoUpgrade.flags = [ "nixpkgs" "-L" ];
      system.autoUpgrade.dates = "02:00";
      system.autoUpgrade.randomizedDelaySec = "45min";
    })
    (if settings.system.security == true then {
      services.fail2ban.enable = true;
      security.apparmor.enable = true;
      security.apparmor.packages = [ pkgs.apparmor-profiles pkgs.firejail ];
      security.apparmor.enableCache = true;
      security.apparmor.killUnconfinedConfinables = true;
      environment.systemPackages = [ pkgs.clamav ];
      services.clamav.scanner.enable = true;
      services.clamav.scanner.interval = "Sat *-*-* 04:00:00";
      security.tpm2.enable = true;
      security.auditd.enable = true;
      security.audit.enable = true;
      networking.firewall.enable = lib.mkForce true;
      security.lockKernelModules = true;
      security.protectKernelImage = true;
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_hardened;
      boot.kernelParams = [
        "kernel.sysrq=0"
        "kernel.kptr_restrict=2"
        "net.core.bpf_jit_enable=0"
        "kernel.ftrace_enabled=false"
        "kernel.dmesg_restrict=1"
        "fs.protected_fifos=2"
        "fs.protected_regular=2"
        "fs.suid_dumpable=0"
        "kernel.perf_event_paranoid=3"
        "kernel.unprvileged_bpf_disabled=1"
        "slab_nomerge"
        "page_poison=1"
        "page_alloc.shuffle=1"
        "debugfs=off"
      ];
      programs.firejail = {
        enable = true;
        wrappedBinaries = {
          google-chrome-stable = {
            executable = "${pkgs.google-chrome}/bin/google-chrome-stable";
            profile = "${pkgs.firejail}/etc/firejail/google-chrome-stable.profile";
          };
          nautilus = {
            executable = "${pkgs.nautilus}/bin/nautilus";
            profile = "${pkgs.firejail}/etc/firejail/nautilus.profile";
          };
          discord = {
            executable = "${pkgs.discord}/bin/discord";
            profile = "${pkgs.firejail}/etc/firejail/discord.profile";
          };
        };
      };
    } else {
      services.journald.extraConfig = "SystemMaxUse=10M";
      systemd.coredump.extraConfig = ''
        [Coredump]
        Storage=none
        ProcessSizeMax=0
      '';
    })
    (lib.mkIf settings.system.sshd {
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings.PasswordAuthentication = true;
        settings.UseDns = true;
        permitRootLogin = "yes";
      };
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
