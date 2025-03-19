{ ... }: {
  imports = [
    ../modules/commands/sh.nix
    ../modules/commands/cli.nix
    ../modules/commands/lib.nix
  ];
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
}
