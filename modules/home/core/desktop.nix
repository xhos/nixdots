{pkgs, ...}: {
  xdg.desktopEntries = let
    web-app-args = "--class=web-app --enable-features=UseOzonePlatform,OverlayScrollbar --ozone-platform=wayland";
  in {
    spotify = {
      name = "Spotify";
      genericName = "Spotify";
      exec = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
      terminal = false;
      categories = ["Application"];
    };

    notion-calendar = {
      name = "Notion Calendar";
      genericName = "Notion Calendar";
      exec = "${pkgs.chromium}/bin/chromium --app=\"https://calendar.notion.so\" ${web-app-args}";
      terminal = false;
      startupNotify = true;
      categories = ["Application"];
    };

    notion = {
      name = "Notion";
      genericName = "Notion";
      exec = "${pkgs.chromium}/bin/chromium --app=\"https://notion.so\" ${web-app-args}";
      terminal = false;
      startupNotify = true;
      categories = ["Application"];
    };

    chatgpt = {
      name = "ChatGPT";
      genericName = "ChatGPT";
      exec = "${pkgs.chromium}/bin/chromium --app=\"https://chatgpt.com\" ${web-app-args}";
      terminal = false;
      startupNotify = true;
      categories = ["Application"];
    };

    yandex-music = {
      name = "Yandex Music";
      genericName = "Yandex Music";
      exec = "${pkgs.chromium}/bin/chromium --app=\"https://next.music.yandex.ru\" ${web-app-args}";
      terminal = false;
      startupNotify = true;
      categories = ["Application"];
    };
  };
}
