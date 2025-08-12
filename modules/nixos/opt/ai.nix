{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.ai.enable {
    services.ollama.enable = true;
    services.ollama.acceleration = "cuda";
  };
}
