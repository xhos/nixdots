{pkgs, ...}: {
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    customComponents = with pkgs.home-assistant-custom-components; [
      yandex-station
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };
}
