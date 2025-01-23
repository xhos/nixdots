{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.vm.enable {
    environment.systemPackages = with pkgs; [quickemu];
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["xhos"];
    virtualisation.spiceUSBRedirection.enable = true;

    virtualisation.libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = [pkgs.OVMFFull.fd];
        };
        swtpm.enable = true;
      };
    };
  };
}
