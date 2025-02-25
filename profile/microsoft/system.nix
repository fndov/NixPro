{ inputs, settings, ... }: {
  imports = [ inputs.nixos-wsl.nixosModules.default ];
  wsl.enable = true;
  wsl.defaultUser = settings.user.name;
}
