{
  inputs = {
    # https://nixos.wiki/wiki/Nix_channels
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # https://nix-community.github.io/home-manager/
    # home-manager.url = "github:nix-community/home-manager"; # Latest release.
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # https://github.com/niksingh710/nsearch
    nsearch.url = "github:niksingh710/nsearch"; nsearch.inputs.nixpkgs.follows = "nixpkgs";
    # https://ghostty.org/docs/install/binary#linux-(official)
    ghostty.url = "github:ghostty-org/ghostty";
  };
  outputs = inputs@{ self, nixpkgs, ghostty, home-manager, ... }: let

    systemSettings = {          # System settings.
      bootMode = "uefi";        # uefi, bios.
      grubDevice = "/dev/sda";  # /dev/sda, /dev/nvme0n1.
      bootMountPath = "/boot";  # mount path for efi boot partition; only used for uefi boot mode.
      system = "x86_64-linux";  # x86_64-linux, aarch64-linux.
      profile = "personal";     # personal, work, server, vm, wsl.
      flakePath = ".nixpro";    # /home/user/flakePath/NixPro
      hostname = "NixPro";     # Anything.
      gpu = "nvidia";           # nvidia, amd, intel.
    };

    userSettings = {            # User settings.
      username = "miyu";        # Anything.
      email = "tommybice1@gmail.com"; # Anything.
      terminal = "ghostty";     # alacritty, ghostty.
      shell = "fish";           # bash, zsh, fish, nushell.
      editor = "micro";         # vim, neovim, micro.
      browser = "firefox";      # firefox, chromium.
      font = "Noto Mono";
      fontPkg = pkgs.noto-fonts;
      wallpaperPath = "Media/Pictures/Wallpapers/Catppuccin-mocha"; # Path to wallpapers.
    };

    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    system = systemSettings.system;

  in {
    nixosConfigurations.${userSettings.username} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs pkgs system systemSettings userSettings; };
      modules = [

        {
          environment.systemPackages = [
            inputs.ghostty.packages.${pkgs.system}.default
            inputs.nsearch.packages.${pkgs.system}.default
          ];

          # NixOS Settings.
          nix.settings.trusted-users = [ "@wheel" ];
          nix.settings.substituters = [ "https://hyprland.cachix.org" ];
          nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
          nix.extraOptions = "experimental-features = nix-command flakes";

          # Boot Settings.
          # boot.loader.grub.useOSProber = true;
          boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
          boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi
          boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
          boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
          boot.loader.grub.device = systemSettings.grubDevice;
        }

        ./profile/${systemSettings.profile}/configuration.nix
        ./system/hardware/${systemSettings.gpu}.nix
        ./system/hardware/hardware.nix
          home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs systemSettings userSettings; };
          home-manager.users.${userSettings.username} = {
            imports = [
              ./profile/${systemSettings.profile}/home.nix
            ];
          };
        }
      ];
    };
  };
}
