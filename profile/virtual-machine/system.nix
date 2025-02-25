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
  boot.loader.timeout = 1;
}
