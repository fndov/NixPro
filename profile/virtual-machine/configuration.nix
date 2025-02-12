/*
  Edit this Configuration file to define what should be installed on
  - your system. Help is available in the configuration.nix(5) man page
  - and in the NixOS manual (accessible by running `nixos-help`).
*/
{ ... }: {
  imports = [ /* Configuration */
    # ../../system/driver/memory.nix
    # ../../system/driver/kernel.nix
    # ../../system/driver/automount.nix
    # ../../system/driver/pipewire.nix
    # ../../system/security/keyring.nix
    # ../../system/security/timezone.nix
  ];
  services.openssh = {
    enable = false;
     ports = [ 22 ];
     settings = {
      PasswordAuthentication = true;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "yes";
    };
  };
  boot.loader.timeout = 1;
}
