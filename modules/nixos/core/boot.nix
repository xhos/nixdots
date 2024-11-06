{pkgs, ...}: {
  boot.loader = {
    systemd-boot.enable = false;

    grub = {
      enable = true;
      theme = "${pkgs.catppuccin-grub}";
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  lib.mkDefault.console = {
    enable = true;
    font = "Lat2-Terminus16";
    useXkbConfig = true; # Makes it so the tty console has about the same layout as the one configured in the services.xserver options.
  };
}
