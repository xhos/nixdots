{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (config.greeter == "sddm") {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";

      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
      ];
    };

    # TODO: figure out how to enable hyprlands session without
    # enabling it on os level. for now idc this has been
    # annoying enough to deal with as it is
    programs.hyprland.enable = true;

    environment.systemPackages = [
      (pkgs.callPackage ../../../derivs/sddm-astronaut-theme.nix {
        theme = "hyprland_kath";
      })
    ];
  };
}
