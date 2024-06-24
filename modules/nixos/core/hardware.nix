{ pkgs, ... }: {
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
      ];
    };
  };
}
