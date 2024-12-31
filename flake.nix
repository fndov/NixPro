{
  inputs = {
    # https://nixos.wiki/wiki/Nix_channels
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # https://nix-community.github.io/home-manager/
    # home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.url = "github:nix-community/home-manager"; # Latest release.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # https://github.com/niksingh710/nsearch
    nsearch.url = "github:niksingh710/nsearch";
    nsearch.inputs.nixpkgs.follows = "nixpkgs";
    # https://ghostty.org/docs/install/binary#nix-flake
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ghostty, ... }: let

    systemSettings = {          # System settings.
      bootMode = "uefi";        # uefi, bios.
      grubDevice = "/dev/sda";  # /dev/sda, /dev/nvme0n1.
      bootMountPath = "/boot";  # mount path for efi boot partition; only used for uefi boot mode.
      system = "x86_64-linux";  # x86_64-linux, aarch64-linux.
      profile = "personal";     # personal, work, server, vm, wsl.
      flakePath = ".nixpro";    # /home/user/flakePath/NixPro
      hostname = "Phantom";      # Anything.
      gpu = "nvidia";            # nvidia, amd, intel.
    };

    userSettings = {            # User settings.
      username = "miyu";        # Anything.
      terminal = "ghostty";     # alacritty, kitty.
      shell = "fish";           # bash, zsh, fish, nushell.
      editor = "micro";         # vim, neovim, micro.
      browser = "firefox";      # firefox, chromium.
      font = "JetBrainsMono Nerd Font";
      fontPkg = pkgs.nerd-fonts.jetbrains-mono;
    };

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    system = systemSettings.system;

  in {
    nixosConfigurations.${userSettings.username} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs pkgs system systemSettings userSettings; };
      modules = [
        ./profile/${systemSettings.profile}/configuration.nix
        ./system/hardware/${systemSettings.gpu}.nix
        ./system/hardware/hardware.nix

        # Only until Ghostty is in nixpkgs.
        { environment.systemPackages = [
          ghostty.packages.x86_64-linux.default
        ]; }

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
