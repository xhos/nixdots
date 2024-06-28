{ stdenv
, fetchpatch
, nukeReferences
, linuxPackages
, kernel ? linuxPackages.kernel
, version
, src
}:

stdenv.mkDerivation {
  name = "samsung-galaxybook-extras-${version}-driver-${kernel.modDirVersion}";
  inherit version;

  buildInputs = [ nukeReferences ];

  kernel = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  inherit src;
  
  src = fetchFromGitHub {
    owner = "joshuagrisham";
    repo = " samsung-galaxybook-extras";
    rev = "d1543077d9d4d064030de4702ca0c67bbd2b2c13";
    hash = "";
  };

  postUnpack = ''
    mkdir $out
    cp -r $src/driver/* $out
    cd $out
  '';

  buildPhase = ''
    make -C /lib/modules/`uname -r`/build M=$PWD
  '';

  installPhase = ''
    sudo make -C /lib/modules/`uname -r`/build M=$PWD modules_install
    sudo depmod
    sudo modprobe samsung-galaxybook
  '';

  meta.platforms = [ "x86_64-linux" ];
}
