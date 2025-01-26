pkgs: self: super: let
  visual-paradigm = {
    stdenv,
    lib,
    fetchurl,
    pkgs,
    patchelf,
  }: let
    version = "17.2";
    src = fetchurl {
      name = "visual-paradigm.tar.gz";
      url = "https://www.visual-paradigm.com/downloads/${version}/vp/Visual_Paradigm_Linux64_InstallFree.tar.gz";
      sha256 = "sha256-pvCSYw0FpoP25iO1lIpowY6KQYi9Ydghnic1PUO/76k=";
    };
  in
    stdenv.mkDerivation rec {
      inherit version;
      pname = "visual-paradigm";
      ldpath = with pkgs; lib.makeLibraryPath [jre zlib];
      inherit src;
      dontStrip = true;
      unpackPhase = ''
        mkdir pkg
        tar xvf $src -C pkg
        sourceRoot=pkg/Visual_Paradigm_${version}
      '';
      buildInputs = with pkgs; [gawk xorg.libXtst makeWrapper];
      installPhase = ''
        mkdir -p $out/bin
        cp -r Application $out/bin
        cp -r jre $out/bin
        cp -r .install4j $out/bin
        cp Visual_Paradigm $out/bin/Visual_Paradigm-unwrapped

        # Create the .desktop file
        mkdir -p $out/share/applications
        cat > $out/share/applications/visual-paradigm.desktop <<EOF
        [Desktop Entry]
        Encoding=UTF-8
        Version=1.0
        Type=Application
        Terminal=false
        Exec=visual-paradigm
        Name=Visual Paradigm
        Icon=$out/bin/Application/resources/vpuml.png
        EOF

        echo "=== PatchElfing away ==="
        # This code should be a bit forgiving of errors, unfortunately
        set +e
        find $out/bin -type f -perm -0100 | while read f; do
          # type=$(readelf -h "$f" 2>/dev/null | grep 'Type:' | sed -e 's/ *Type: *\([A-Z]*\) (.*/\1/')
          type="EXEC"
          if [ -z "$type" ]; then
            :
          elif [ "$type" == "EXEC" ]; then
            echo "patching $f executable <<"
            patchelf --shrink-rpath "$f"
            patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "$(patchelf --print-rpath "$f"):${ldpath}" \
              "$f" \
              && patchelf --shrink-rpath "$f" \
              || echo unable to patch ... ignoring 1>&2
          elif [ "$type" == "DYN" ]; then
            echo "patching $f library <<"
            patchelf \
              --set-rpath "$(patchelf --print-rpath "$f"):${ldpath}" \
              "$f" \
              && patchelf --shrink-rpath "$f" \
              || echo unable to patch ... ignoring 1>&2
          else
            echo "not patching $f <<: unknown elf type"
          fi
        done

        # We need to unpack the files
        unpack_file() {
          echo "=== Unpacking $1 ==="
          if [ -f "$1" ]; then
            jar_file=`echo "$1" | awk '{ print substr($0,1,length($0)-5) }'`
            $out/bin/jre/bin/unpack200 -r "$1" "$jar_file"

            if [ $? -ne 0 ]; then
              echo "Error unpacking jar files. The architecture or bitness (32/64)"
              echo "of the bundled JVM might not match your machine."
              echo "You might also need administrative privileges for this operation."
              exit 1
            else
              chmod a+r "$jar_file"
            fi
          fi
        }

        run_unpack200() {
          if [ -d "$1/lib" ]; then
            old_pwd200=`pwd`
            cd "$1"
            for pack_file in lib/*.jar.pack
            do
              unpack_file $pack_file
              rm -f $pack_file
            done
            for pack_file in lib/ext/*.jar.pack
            do
              unpack_file $pack_file
              rm -f $pack_file
            done
            cd "$old_pwd200"
          fi
        }

        run_unpack200 $out/bin/jre
        run_unpack200 $out/bin/jre/jre

        makeWrapper $out/bin/Visual_Paradigm-unwrapped $out/bin/visual-paradigm \
        --set INSTALL4J_JAVA_HOME_OVERRIDE ${pkgs.openjdk11} \
        --set _JAVA_AWT_WM_NONREPARENTING 1
      '';
    };
in {
  visual-paradigm = pkgs.callPackage visual-paradigm {};
}
