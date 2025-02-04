/* NixOS-WSL Configuration 
- Managed by WSL and processed by Flake
- Mounts available at /mnt/[driveletter]
- Use 'wsl' command for Windows integration */
{ inputs, settings, ... }: {
  imports = [ /* Configuration */
    inputs.nixos-wsl.nixosModules.default
    ../../system/security/extra.nix
    ../../system/security/firewall.nix
    ../../system/security/timezone.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = settings.user.name;

  system.stateVersion = settings.system.version;
}
