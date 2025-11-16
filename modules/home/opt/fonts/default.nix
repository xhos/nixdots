{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.fonts.enable {
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
      noto-fonts-color-emoji
      poppins

      roboto
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.zed-mono
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
    ];
  };
}
