{
  description = "NixPro. Started June 19, 2024";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, ... }: let
    settings = {
      profile = "standalone";
      driver = {
        graphics = "nvidia";
        networking = true;
        bluetooth = true;
        usbmuxd = true;
      };
      system = {
        version = "24.11";
        architecture = "x86_64-linux";
        bootMode = "uefi";
        grubDevice = "/dev/sda";
        bootMountPath = "/boot";
        flakePath = ".nixpro";
        automation = false;
        printing = true;
        timezone = true;
        security = false;
        sshd = false;
      };
      user = {
        name = "miyu";
        password = "unlock";
        email = "";
        terminal = "ghostty";
        shell = "fish";
        editor = "micro";
        browser = "firefox";
      };
      desktop = {
        type = "hyprland";
        font = "Noto";
        fontPkg = "noto-fonts";
        wallpaperPath = "Media/Pictures/Wallpapers";
        wallpaperName = "nix-wallpaper-dracula.png";
        animationSpeed = "medium";
      };
    };
    system = settings.system.architecture;
  in {
    nixosConfigurations.workstation = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        ./profile/workstation/hardware.nix
        ./profile/workstation/default.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.terminal then [
        ./modules/apps/${settings.user.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.browser then [
        ./modules/apps/${settings.user.browser}.nix
      ] else []);
    };
    nixosConfigurations.virtual-machine = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        ./profile/virtual-machine/hardware.nix
        ./profile/virtual-machine/default.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.terminal then [
        ./modules/apps/${settings.user.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.browser then [
        ./modules/apps/${settings.user.browser}.nix
      ] else []);
    };
    nixosConfigurations.windows-subsystem = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        ./profile/windows-subsystem/hardware.nix
        ./profile/windows-subsystem/default.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.terminal then [
        ./modules/apps/${settings.user.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.browser then [
        ./modules/apps/${settings.user.browser}.nix
      ] else []);
    };
    nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        ./profile/server/hardware.nix
        ./profile/server/default.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.terminal then [
        ./modules/apps/${settings.user.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.browser then [
        ./modules/apps/${settings.user.browser}.nix
      ] else []);
    };
    nixosConfigurations.installation-media = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        ./profile/installation-media/hardware.nix
        ./profile/installation-media/default.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.terminal then [
        ./modules/apps/${settings.user.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.browser then [
        ./modules/apps/${settings.user.browser}.nix
      ] else []);
    };
    darwinSystem.darwin = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        ./profile/darwin/hardware.nix
        ./profile/darwin/default.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.terminal then [
        ./modules/apps/${settings.user.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.user.browser then [
        ./modules/apps/${settings.user.browser}.nix
      ] else []);
    };
  };
}
