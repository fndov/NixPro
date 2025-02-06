{ pkgs, settings, ... }: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  users.users.settings.user.name.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];
}
