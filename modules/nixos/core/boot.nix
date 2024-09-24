{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  console = {
    enable = true;
    font = "Lat2-Terminus16";
    useXkbConfig = true; # Makes it so the tty console has about the same layout as the one configured in the services.xserver options.
  };
}