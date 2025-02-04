{ ... }: {
  services.openssh = {
    enable = true;
     ports = [ 22 ];
     settings = {
      PasswordAuthentication = true;
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "yes";
    };
  };
}
