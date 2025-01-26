{pkgs}: let
  mkWebAppIcon = {
    name,
    url,
    hash,
  }:
    pkgs.fetchurl {
      name = "${name}-icon";
      inherit url hash;
    };
in {
  notion = mkWebAppIcon {
    name = "notion";
    url = "https://upload.wikimedia.org/wikipedia/commons/4/45/Notion_app_logo.png";
    hash = "sha256-2oAdZZ2JFjIODXbIxiFU6XodRPcXYvKhjRyMGFYk1b4=";
  };

  notion-calendar = mkWebAppIcon {
    name = "notion-calendar";
    url = "https://cdn.dribbble.com/userupload/4769021/file/original-ecd9b13c7aef39a45bb6ff71e8e5c35b.png";
    hash = "sha256-NEmvWe8pwnj6gZhF7ywAV7/eSavxeKSqUVI/9KUoVJQ=";
  };

  chatgpt = mkWebAppIcon {
    name = "chatgpt";
    url = "https://upload.wikimedia.org/wikipedia/commons/0/04/ChatGPT_logo.svg";
    hash = "sha256-Wo2tKGTMHIEJ6650vqRH3y8wuXi9rVZ0kkfEBuHLIic=";
  };

  yandex-music = mkWebAppIcon {
    name = "yandex-music";
    url = "https://upload.wikimedia.org/wikipedia/commons/f/fa/Yandex_Music_icon_2023.svg";
    hash = "sha256-Q/oyTftMAsHLIyPxNAr88IGFxFlGt58rHmgy0J01ado=";
  };
}
