{ pkgs, config, ... }:

{
  hardware.opengl = {
    enable = true;
  };

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  services.xserver.videoDrivers = [ "nvidia" ];
}
