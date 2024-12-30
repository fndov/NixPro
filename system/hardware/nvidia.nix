{ pkgs, config, ... }:
{
  environment.systemPackages = [ pkgs.nvtopPackages.full ];

  boot.blacklistedKernelModules = [ "nouveau" ]; # "nouveau" sucks. "nvidiafb" GPU passthrough.
  boot.kernelParams = [
  # "nvidia_drm"
  # "nvidia_modeset"
  # "nvidia_uvm"
  # "nvidia-drm.fbdev=1"
  # "nvidia"
  ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    # ^ Works best with `boot.kernelPackages = pkgs.linuxPackages;`
    powerManagement = {
      enable = false;
      finegrained = true;
    };
    modesetting.enable = true;
    nvidiaSettings = false;
    open = false;
    };
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:9:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}