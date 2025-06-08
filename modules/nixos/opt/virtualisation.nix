{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.vm.enable {
    programs.dconf.enable = true;
    users.users.xhos.extraGroups = ["libvirtd"];
    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
      # quickemu
    ];
    services.qemuGuest.enable = true;
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["xhos"];
    virtualisation = {
      docker.enable = true;
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    services.spice-vdagentd.enable = true;
  };
}
