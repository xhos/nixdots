_: ''
  #!/usr/bin/env sh
  THEME=$1
  sed -i "s/theme = .*/ theme  = \"$THEME\";"/1 /etc/nixos/home/xhos/home.nix
  cd /etc/nixos && home-manager switch --flake ".#$USER@gbook"
  echo $THEME > /tmp/themeName
''
