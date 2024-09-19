{pkgs, ...}: {
  gtk = {
    enable = true;
    iconTheme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
    };
  };
}
