{
  config,
  pkgs,
  ...
}: {
  sops.secrets."api/oci/ca".mode = "0600";
  sops.secrets."api/oci/eu".mode = "0600";

  home.file.".oci/config_source" = {
    text = ''
      [DEFAULT]
      user=ocid1.user.oc1..aaaaaaaaldxiwbisri7smdkcznn2wvb7cfedx2hoegdzrvmz276gbkguhnlq
      fingerprint=1c:93:59:80:34:37:29:41:df:b8:a1:c2:80:4e:a2:b9
      key_file=${config.sops.secrets."api/oci/ca".path}
      tenancy=ocid1.tenancy.oc1..aaaaaaaaqecxqejolfgwkctehfwo35q6m67zt2lywowqcixzdrg7n6izc5hq
      region=ca-toronto-1
      [EU]
      user=ocid1.user.oc1..aaaaaaaal2tnczxpb3nwyh32nuytuqhcgxzbl2pqujkjdn7wp27bpzj2lfja
      fingerprint=c5:9b:b7:38:d4:61:bd:39:88:7d:42:1f:32:6f:52:ce
      key_file=${config.sops.secrets."api/oci/eu".path}
      tenancy=ocid1.tenancy.oc1..aaaaaaaag6hv7eiqvisldbks6ga545vwrssxgidfei5cpr6dptvwq5yko5lq
      region=eu-frankfurt-1
    '';
    onChange = ''
      cat ~/.oci/config_source > ~/.oci/config
      chmod 600 ~/.oci/config
      rm -f ~/.oci/config_source
    '';
    force = true;
  };

  home.packages = with pkgs; [
    oci-cli

    (writeShellApplication {
      name = "oci-sync-proxy";
      runtimeInputs = [oci-cli jq];
      text = ''
        SOURCE_PROFILE="DEFAULT"
        SOURCE_SECLIST="ocid1.securitylist.oc1.ca-toronto-1.aaaaaaaamaw5mhc4islzadpn7x7pfu63ocnzazwdzfmmofswmdw6uetuxhhq"

        DEST_PROFILE="EU"
        DEST_SECLIST="ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaadgcu5gqz3oqxsexj726pj7ef543y42n3ngukbmycjhypjzfuo4lq"

        echo "fetching security rules from CA proxy subnet..."
        SOURCE_DATA=$(oci network security-list get \
          --security-list-id "$SOURCE_SECLIST" \
          --profile "$SOURCE_PROFILE")

        INGRESS=$(echo "$SOURCE_DATA" | jq -c '.data."ingress-security-rules"')
        EGRESS=$(echo "$SOURCE_DATA" | jq -c '.data."egress-security-rules"')

        echo "applying to EU proxy subnet..."
        oci network security-list update \
          --security-list-id "$DEST_SECLIST" \
          --ingress-security-rules "$INGRESS" \
          --egress-security-rules "$EGRESS" \
          --profile "$DEST_PROFILE" \
          --force

        echo "proxy subnet security rules synced"
      '';
    })
  ];
}
