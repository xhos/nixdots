# {pkgs, ...}: {
#   dconf.settings = {
#     "org/gnome/desktop/interface" = {
#       color-scheme = "prefer-dark";
#     };
#   };

#   gtk = {
#     enable = true;
#     theme = {
#       name = "Adwaita-dark";
#       package = pkgs.gnome-themes-extra;
#     };
#     iconTheme = {
#       name = "Papirus-Dark";
#       package = pkgs.papirus-icon-theme.override {color = "nordic";};
#     };
#   };

#   qt = {
#     enable = true;
#     platformTheme.name = "adwaita";
#     style.name = "adwaita-dark";
#   };
# }
