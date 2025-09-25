{
  description = "NixPro. Started June 19, 2024";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
    # nixos-wsl.url = "github:nix-community/NixOS-WSL";
    # nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };
  outputs = inputs@{ ... }: let
    settings = {
      timezone = "America/Chicago";
      driver.graphics = "nvidia";
      driver.intelBusID = "PCI:0:2:0";
      driver.nvidiaBusID = "PCI:9:0:0";
      system.version = "25.05";
      system.architecture = "x86_64-linux";
      system.bootMode = "uefi";
      system.grubDevice = "/dev/sda";
      system.bootMountPath = "/boot";
      system.flakePath = ".nixpro";
      system.automation = false;
      system.security = false;
      system.sshd = false;
      account.name = "tommy";
      account.email = "miyu@allthingslinux.org";
      account.password = "$6$4oIhgNCDy8qpD9k3$IjLevO4A8W40sPqTT4BzCa7LKrMOmCnbfey5L94K/tQpa48eely7BLJNJzlztHUzAvQQfhaFYiaGlKDJqgBGM1";
      account.terminal = "ghostty";
      account.shell = "fish";
      account.editor = "flow";
      account.browser = "google-chrome";
      desktop.type = "gnome";
      desktop.monitors = [ "eDP-1,1920x1080@60,0x0,1" "Virtual-1,1920x1080@60,0x0,1" ];
      desktop.wallpaperPath = "Media/Pictures/Wallpapers";
      desktop.wallpaperName = "nix-wallpaper-dracula.png";
      desktop.wallpaperMonitor = "eDP-1";
      desktop.animationSpeed = "medium";
    };
    system = settings.system.architecture;
  in {
    nixosConfigurations.workstation = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; settings = settings // { profile = "workstation"; }; };
      modules = [
        inputs.chaotic.nixosModules.nyx-cache
        inputs.chaotic.nixosModules.nyx-overlay
        inputs.chaotic.nixosModules.nyx-registry
        inputs.home-manager.nixosModules.home-manager
        ./profile/workstation/hardware.nix
        ./profile/workstation/configuration.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./modules/desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.terminal then [
        ./modules/apps/${settings.account.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.browser then [
        ./modules/apps/${settings.account.browser}.nix
      ] else []);
    };
    nixosConfigurations.virtual-machine = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; settings = settings // { profile = "virtual-machine"; }; };
      modules = [
        inputs.chaotic.nixosModules.nyx-cache
        inputs.chaotic.nixosModules.nyx-overlay
        inputs.chaotic.nixosModules.nyx-registry
        inputs.home-manager.nixosModules.home-manager
        ./profile/virtual-machine/hardware.nix
        ./profile/virtual-machine/configuration.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./modules/desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.terminal then [
        ./modules/apps/${settings.account.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.browser then [
        ./modules/apps/${settings.account.browser}.nix
      ] else []);
    };
    nixosConfigurations.windows-subsystem = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; settings = settings // { profile = "windows-subsystem"; }; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./profile/windows-subsystem/hardware.nix
        ./profile/windows-subsystem/configuration.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./modules/desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.terminal then [
        ./modules/apps/${settings.account.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.browser then [
        ./modules/apps/${settings.account.browser}.nix
      ] else []);
    };
    nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; settings = settings // { profile = "server"; }; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
         inputs.determinate.nixosModules.default
        ./profile/server/hardware.nix
        ./profile/server/configuration.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./modules/desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.terminal then [
        ./modules/apps/${settings.account.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.browser then [
        ./modules/apps/${settings.account.browser}.nix
      ] else []);
    };
    nixosConfigurations.image = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; settings = settings // { profile = "image"; }; };
      modules = [
        inputs.chaotic.nixosModules.nyx-cache
        inputs.chaotic.nixosModules.nyx-overlay
        inputs.chaotic.nixosModules.nyx-registry
        inputs.home-manager.nixosModules.home-manager
        ./profile/image/hardware.nix
        ./profile/image/configuration.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./modules/desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.terminal then [
        ./modules/apps/${settings.account.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.browser then [
        ./modules/apps/${settings.account.browser}.nix
      ] else []);
    };
    darwinSystem.darwin = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; settings = settings // { profile = "darwin"; }; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./profile/darwin/configuration.nix
        ./compose.nix
      ] ++ (if !builtins.isNull settings.desktop.type then [
        ./modules/desktop/${settings.desktop.type}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.terminal then [
        ./modules/apps/${settings.account.terminal}.nix
      ] else [])
      ++ (if !builtins.isNull settings.account.browser then [
        ./modules/apps/${settings.account.browser}.nix
      ] else []);
    };
  };
}
