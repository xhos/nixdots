{pkgs, ...}: {
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "nordic";};
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
}
