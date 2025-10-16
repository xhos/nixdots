{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ./disko.nix
  ];

  networking.hostName = "vyverne";
  networking.hostId = "9a7bef04";

  impermanence.enable = true;
  audio.enable = true;
  bluetooth.enable = true;
  steam.enable = true;
  greetd.enable = true;
  nvidia.enable = true;
  vm.enable = true;
  ai.enable = true;
  boot.enable = true;

  greeter = "autologin";

  users.users.xhos.openssh.authorizedKeys.keyFiles = [./vyverne.pub];

  services.hardware.openrgb.enable = true;
  programs.adb.enable = true;

  systemd.tmpfiles.rules = [
    "d /games 0755 xhos users - -"
  ];

  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  boot.kernelParams = ["hid_apple.fnmode=2"];
  boot.supportedFilesystems = ["zfs"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.login1.power-off" ||
           action.id == "org.freedesktop.login1.reboot") &&
          subject.user == "xhos") {
        return polkit.Result.YES;
      }
    });
  '';
}
