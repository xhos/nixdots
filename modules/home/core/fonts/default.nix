{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.file.".local/share/fonts".source = ./font-files;
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
    noto-fonts-cjk-sans
    noto-fonts-emoji
    
    roboto
    hack-font
    nerd-fonts.fira-code
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.zed-mono
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];
}