{ pkgs, ... }: {
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
      ];
    };
  };
}
