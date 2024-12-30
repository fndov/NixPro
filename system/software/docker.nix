{ pkgs, lib, userSettings, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    storageDriver = storageDriver;
    autoPrune.enable = true;
  };
  users.users.userSettings.username.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];
}
