{...}: {

  imports = [
    ../../modules
  ];

  gpu.amd.enable = true;

  networking.hostName = "DESKTOP-VKFSNVPI";

  configapps.enable = true;
  appimages.enable = true;

  dev.enable = true;
  dev.unity.enable = true;

  games.enable = true;
  games.emulators.enable = true;

  videos.enable = true;

  vms.enable = true;

  libreoffice.enable = true;
}
