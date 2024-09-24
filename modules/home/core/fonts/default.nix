{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  file.".local/share/fonts".source = ./font-files;
  home.packages = with pkgs; [
    # icon fonts
    material-design-icons

    # normal fonts
    font-awesome
    dosis
    rubik
    lexend
    lexend
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto

    (nerdfonts.override {fonts = ["FiraCode" "FantasqueSansMono" "ZedMono" "Iosevka" "JetBrainsMono"];})
  ];
}