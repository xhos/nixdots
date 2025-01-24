{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.ai.enable {
    services.ollama.enable = true;
    services.ollama.acceleration = "cuda";

    # broken :(
    # programs.bash.shellInit = ''
    #   export OPENAI_API_KEY="$(cat ${config.sops.secrets."api_keys/openai".path})"
    #   export GOOGLE_AI_API_KEY="$(cat ${config.sops.secrets."api_keys/gemeni".path})"
    #   export ANTHROPIC_API_KEY="$(cat ${config.sops.secrets."api_keys/anthropic".path})"
    # '';
  };
}
