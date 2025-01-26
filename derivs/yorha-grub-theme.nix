{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "yorha-grub-theme";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "OliveThePuffin";
    repo = "yorha-grub-theme";
    rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";
    hash = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out"
    cp -r yorha-* "$out/"
  '';

  meta = {
    description = "YoRHa GRUB themes for multiple resolutions";
    homepage = "https://github.com/OliveThePuffin/yorha-grub-theme";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
