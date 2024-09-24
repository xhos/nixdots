{
  services.ollama.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };
}
