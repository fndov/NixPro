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
      driver = {
        networking = true;
        bluetooth = false;
        usbmuxd = false;
        graphics = "intel";
      };
      system = {
        version = "24.11";
        architecture = "x86_64-linux";
        bootMode = "uefi";
        grubDevice = "/dev/sda";
        bootMountPath = "/boot";
        flakePath = ".nixpro";
        automation = false;
        timezone = true;
        security = false;
        sshd = false;
      };
      user = {
        name = "miyu";
        email = "";
        terminal = "ghostty";
        shell = "fish";
        editor = "micro";
        browser = "firefox";
      };
      desktop = {
        type = "plasma";
        font = "Noto";
        fontPkg = pkgs.noto-fonts;
        wallpaperPath = "";
        wallpaperName = "";
        animationSpeed = "medium";
      };
    };
    system = settings.system.architecture;
    pkgs = import inputs.nixpkgs { inherit system; };
  in {
    nixosConfigurations.${settings.user.name} = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [ 
        inputs.home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = { inherit inputs settings; };
          home-manager.users.${settings.user.name} = {
            imports = [
              ./compose/home.nix
              ./profile/${settings.profile}/home.nix
            ] ++ (if !builtins.isNull settings.desktop.type then [ ./desktop/${settings.desktop.type}/home.nix ] else []);
          };
        }
        ./modules/system/hardware.nix
        ./compose/system.nix
        ./profile/${settings.profile}/system.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [ ./desktop/${settings.desktop.type}/system.nix ] else []);
    };
  };
}
