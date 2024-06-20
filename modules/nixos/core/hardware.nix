{ pkgs, ... }: {
  hardware = {
    bluetooth.enable = true;
    bluetooth.input.General = {ClassicBondedOnly = false;};
    
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
      ];
    };
  };
}
