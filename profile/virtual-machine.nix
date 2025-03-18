{ ... }: {
  imports = [
    ../../user/software/commands/sh.nix
    ../../user/software/commands/cli.nix
    ../../user/software/commands/lib.nix
  ];
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
}
