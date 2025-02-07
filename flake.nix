{
  description = "NixPro. Modular configuration framework started June 19, 2024";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nsearch.url = "github:niksingh710/nsearch";
    nsearch.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, ... }: let
    
    settings = {    
    
      system = {
        version = "24.11";
        architecture = "x86_64-linux";
        bootMode = "uefi";
        grubDevice = "/dev/sda";
        bootMountPath = "/boot";
        flakePath = ".nixpro";
        networking = true;
        automation = false;
        timezone = true;
        security = false;
        sshd = false;
        gpu = "intel";
      };
      
      profile = "image";

      user = {
        name = "miyu";
        email = "tommybice1@gmail.com";
        terminal = "ghostty";
        shell = "fish";
        editor = "micro";
        browser = "firefox";
      };
      
      desktop = {
        enable = true;
        type = "wm";
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
          environment.systemPackages = [ inputs.nsearch.packages.${pkgs.system}.default ];
          nix.settings.substituters = [ "https://hyprland.cachix.org" ];
          nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        }
        ./system/driver/hardware.nix # Will need to be pre-set for an Image.
        ./system/driver/${settings.system.gpu}.nix
        ./system/compose/default.nix
        ./profile/${settings.profile}/configuration.nix
        ./system/${settings.desktop.type}/default.nix
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false; 
          home-manager.backupFileExtension = "hm-backup";
          home-manager.extraSpecialArgs = { inherit inputs settings; };
          home-manager.users.${settings.user.name}.imports = [
            ./profile/${settings.profile}/home.nix
            ./user/${settings.desktop.type}/${ if settings.desktop.type == "wm" then settings.desktop.wm else settings.desktop.de }/default.nix
          ];
        }
      ];
    };
  };
}


