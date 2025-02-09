/* 
  NixOS-WSL Configuration 
  - Managed by WSL and processed by Flake
  - Mounts available at /mnt/[driveletter]
  - Use 'wsl' command for Windows integration 
*/
{ inputs, settings, ... }: {
  imports = [ /* Configuration */
    inputs.nixos-wsl.nixosModules.default
  ];
  wsl.enable = true;
  wsl.defaultUser = settings.user.name;
}
