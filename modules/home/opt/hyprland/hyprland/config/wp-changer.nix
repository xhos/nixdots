{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = [
    # This script will randomly go through the files of a directory, setting it
    # up as the wallpaper at regular intervals
    (pkgs.writeShellApplication {
      name = "wp-changer";
      runtimeInputs = [inputs.swww.packages.${pkgs.system}.swww];

      text = ''
        WALLS_DIR="${config.wallsDir}"

        if [[ -z "$WALLS_DIR" ]] || [[ ! -d "$WALLS_DIR" ]]; then
          echo "Error: config.wallsDir is not set or is not a valid directory"
          exit 1
        fi

        # Edit below to control the images transition
        export SWWW_TRANSITION_FPS=60
        export SWWW_TRANSITION_STEP=2

        # This controls (in seconds) when to switch to the next image
        INTERVAL=600

        while true; do
          find "$WALLS_DIR" -type f \
            | while read -r img; do
              echo "$((RANDOM % 1000)):$img"
            done \
            | sort -n | cut -d':' -f2- \
            | while read -r img; do
              swww img "$img" -t random
              sleep $INTERVAL
            done
        done
      '';
    })
  ];
}
