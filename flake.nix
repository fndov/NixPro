{
  description = "NixPro. Modular configuration framework started June 19, 2024";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, ... }: let
    settings = {
      profile = "image";
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
        gpu = "nvidia";
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
        enable = true;
        type = "wm";
        wm = "hyprland";
        de = "plasma";
        font = "Noto";
        fontPkg = pkgs.noto-fonts;
        wallpaperPath = "Media/Pictures/Wallpapers/Catppuccin-mocha";
        wallpaperName = "purpled-night.jpg";
        animationSpeed = "medium";
      };
    };
    system = settings.system.architecture;
    pkgs = import inputs.nixpkgs { inherit system; };
  in {
    nixosConfigurations.${settings.user.name} = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs pkgs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager { 
          home-manager.users.${settings.user.name}.imports = [ 
            ./profile/${settings.profile}/home.nix 
          ]; 
        }
        ./system/compose/default.nix
        ./system/driver/hardware.nix
        ./profile/${settings.profile}/configuration.nix
        ./system/${settings.desktop.type}/default.nix
      ];
    };
  };
}