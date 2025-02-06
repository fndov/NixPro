/* NixPro - A modular NixOS configuration framework
- This flake serves as the entry point for system configuration
- Settings and profile selection are defined here
- Documentation: https://github.com/fndov/NixPro/ */
{
  description = "NixPro. Started June 19, 2024";
  inputs = { /*
    https://nixos.wiki/wiki/Nix_channels
    https://nix-community.github.io/NixOS-WSL/
    https://nix-community.github.io/home-manager/
    https://github.com/niksingh710/nsearch
    https://github.com/Gerg-L/spicetify-nix */
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nsearch.url = "github:niksingh710/nsearch";
    nsearch.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, ... }: let
    settings = {    
      profile = "microsoft";
      system = {
        bootMode = "uefi";
        grubDevice = "/dev/sda";
        bootMountPath = "/boot";
        architecture = "x86_64-linux";
        flakePath = ".nixpro";
        version = "24.05";
        gpu = "intel";
      };
      user = {
        name = "miyu";
        email = "tommybice1@gmail.com";
        terminal = "ghostty";
        shell = "fish";
        editor = "micro";
        browser = "firefox";
      };
      desktop = {
        enable = false;
        type = "de";
        wm = "hyprland";
        de = "plasma";
        font = "Noto Mono";
        fontPkg = pkgs.noto-fonts;
        wallpaperPath = "Media/Pictures/Wallpapers/Catppuccin-mocha";
        wallpaperName = "purpled-night.jpg";
        animationSpeed = "medium";
      };
    };
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    system = settings.system.architecture;
  in {
    nixosConfigurations.${settings.user.name} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs pkgs system settings; };
      modules = [
        {
          networking.hostName = 
          if settings.profile == "apple" then "NixPro-ARM"
          else if settings.profile == "microsoft" then "NixPro-WSL" 
          else if settings.profile == "server" then "NixPro-Server" 
          else if settings.profile == "standalone" then "NixPro" 
          else if settings.profile == "virtual-machine" then "NixPro-VM"
          else if settings.profile == "image" then "NixPro-Image"
          else "NixPro";
          environment.systemPackages = [ inputs.nsearch.packages.${pkgs.system}.default ];
          nix.settings.trusted-users = [ "@wheel" ];
          nix.extraOptions = "experimental-features = nix-command flakes";
          nix.settings.substituters = [ "https://hyprland.cachix.org" ];
          nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        }
        
        ./system/hardware/hardware.nix # Will need to be pre-set for an Image.
        ./profile/${settings.profile}/configuration.nix
        ./system/hardware/${settings.system.gpu}.nix
        ./system/security/account/default.nix
        (if settings.desktop.enable then ./system/${settings.desktop.type}/default.nix else {})

        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true; 
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = { inherit inputs settings; };
          home-manager.users.${settings.user.name}.imports = [ 
            
            ./profile/${settings.profile}/home.nix

            (if settings.desktop.enable then (toString ./.) + "/user/${settings.desktop.type}/${
              if settings.desktop.type == "wm" 
              then settings.desktop.wm 
              else settings.desktop.de
            }/default.nix" else {})
          ];
        }
      ];
    };
  };
}
