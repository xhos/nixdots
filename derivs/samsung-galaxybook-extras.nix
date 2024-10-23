{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kmod,
}:
stdenv.mkDerivation rec {
  name = "samsung-galaxybook-extras-${version}-${kernel.version}";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "joshuagrisham";
    repo = "samsung-galaxybook-extras";
    rev = "d1543077d9d4d064030de4702ca0c67bbd2b2c13";
    sha256 = "sha256-O65ikBPW+ZIewT+z0alXqxk/wTeCa+dM0OmUZcpe8E0=";
  };

  sourceRoot = "source/driver";
  hardeningDisable = ["pic" "format"]; # 1
  nativeBuildInputs = kernel.moduleBuildDependencies; # 2

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}" # 3
    "KERNEL_SRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" # 4
    "INSTALL_MOD_PATH=$(out)" # 5
  ];

  installPhase = ''
    make SHELL=${stdenv.shell} KERNELRELEASE=${kernel.modDirVersion} KERNEL_SRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build INSTALL_MOD_PATH=$out modules_install
  '';

  meta = with lib; {
    description = "Mimics Samsung System Event Controller, allowing for more configuration.";
    homepage = "https://github.com/joshuagrisham/samsung-galaxybook-extras";
    license = licenses.gpl2;
    maintainers = [maintainers.derock];
    platforms = platforms.linux;
  };
}
