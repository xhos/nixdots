{
  pkgs,
  config,
  ...
}: {
  sops.secrets."ssh/vyverne" = {
    mode = "0600";
    owner = "hass";
  };

  services.home-assistant = {
    enable = true;
    openFirewall = true;
    customComponents = with pkgs.home-assistant-custom-components; [
      yandex-station
    ];
    config = {
      default_config = {};
      wake_on_lan = {};

      shell_command = {
        shutdown_vyverne = "${pkgs.openssh}/bin/ssh -i ${config.sops.secrets."ssh/vyverne".path} -o StrictHostKeyChecking=no -p 10022 xhos@10.0.0.11 sudo shutdown -h now";
      };

      switch = [
        {
          platform = "wake_on_lan";
          mac = "c8:fe:0f:d0:3c:68";
          name = "PC Power";
          host = "10.0.0.11";
          turn_off = {
            service = "shell_command.shutdown_vyverne";
          };
        }
      ];

      automation = [
        {
          alias = "Yandex - Turn On Computer";
          trigger = [
            {
              platform = "event";
              event_type = "yandex_speaker";
              event_data = {
                value = "ничего не делай";
                entity_id = "media_player.yandex_station_xk0000000000000286720000e2296918";
              };
            }
          ];
          action = [
            {
              service = "switch.turn_on";
              target.entity_id = "switch.pc_power";
            }
            {
              service = "media_player.play_media";
              target.entity_id = "media_player.yandex_station_xk0000000000000286720000e2296918";
              data = {
                media_content_type = "text";
                media_content_id = "Включаю компьютер";
              };
            }
          ];
          mode = "single";
        }
        {
          alias = "Yandex - Turn Off Computer";
          trigger = [
            {
              platform = "event";
              event_type = "yandex_speaker";
              event_data = {
                value = "ничего не делай!";
                entity_id = "media_player.yandex_station_xk0000000000000286720000e2296918";
              };
            }
          ];
          action = [
            {
              service = "switch.turn_off";
              target.entity_id = "switch.pc_power";
            }
            {
              service = "media_player.play_media";
              target.entity_id = "media_player.yandex_station_xk0000000000000286720000e2296918";
              data = {
                media_content_type = "text";
                media_content_id = "Выключаю компьютер";
              };
            }
          ];
          mode = "single";
        }
      ];
    };
  };
}
