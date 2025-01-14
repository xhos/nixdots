{pkgs, ...}: let
  webAppIcons = import ./icons.nix {inherit pkgs;};

  mkWebApp = {
    name,
    url,
    iconName ? null,
  }: {
    name = name;
    genericName = name;
    exec = "${pkgs.chromium}/bin/chromium --app=\"${url}\" --enable-features=UseOzonePlatform --ozone-platform=wayland";
    icon =
      if iconName != null
      then webAppIcons.${iconName}
      else "chromium";
    terminal = false;
    startupNotify = true;
    categories = ["Application"];
  };
in {
  xdg.desktopEntries = {
    notion-calendar = mkWebApp {
      name = "Notion Calendar";
      url = "https://calendar.notion.so";
      iconName = "notion-calendar";
    };

    notion = mkWebApp {
      name = "Notion";
      url = "https://notion.so";
      iconName = "notion";
    };

    chatgpt = mkWebApp {
      name = "ChatGPT";
      url = "https://chatgpt.com";
      iconName = "chatgpt";
    };

    yandex-music = mkWebApp {
      name = "Yandex Music";
      url = "https://next.music.yandex.ru";
      iconName = "yandex-music";
    };
  };
}
