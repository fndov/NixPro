{ ... }:

{
  # Firewall, this sucks so make it better.
  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ]; # syncthing
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
