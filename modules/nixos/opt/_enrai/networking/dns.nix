{
  lib,
  config,
  ...
}: let
  enraiIP = config._enrai.config.enraiLocalIP;
  localDomain = config._enrai.config.localDomain;

  exposedServices = lib.mapAttrs (name: svc:
    svc
    // {
      subdomain =
        if svc.subdomain != ""
        then svc.subdomain
        else name;
    })
  config._enrai.exposedServices;

  localServices = lib.filterAttrs (name: svc: !svc.exposed) exposedServices;

  mkRewrites =
    lib.mapAttrsToList (name: svc: {
      domain = "${svc.subdomain}.${localDomain}";
      answer = enraiIP;
      enabled = true;
    })
    localServices;
in {
  services.resolved = {
    enable = true;
    dnssec = "false";
    fallbackDns = ["1.1.1.1" "8.8.8.8"];
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  networking.nameservers = ["127.0.0.1" "1.1.1.1"];

  services.adguardhome = {
    enable = true;
    openFirewall = true;
    mutableSettings = false;
    port = 9393;

    settings = {
      dns = {
        bind_hosts = ["127.0.0.1" "10.0.0.10"];
        port = 53;
        bootstrap_dns = ["1.1.1.1"];
        upstream_dns = ["1.1.1.1"];
      };

      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        rewrites = mkRewrites;
      };
    };
  };
}
