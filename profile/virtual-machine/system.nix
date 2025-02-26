{ ... }: {
  imports = [ /* Configuration */ ];

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
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
  boot.loader.timeout = 1;
}
