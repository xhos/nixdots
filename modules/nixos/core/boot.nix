{
  boot = {
    kernelParams = [ "i915.force_probe=46a6" ]; # https://nixos.wiki/wiki/Intel_Graphics

    # kernel.sysctl."net.isoc" = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # efi.efiSysMountPoint = "/boot";
    };
  };
}
