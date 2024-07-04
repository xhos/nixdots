{
  services = {
      syncthing = {
          enable = true;
          user = "xhos";
          dataDir = "/home/xhos/obsidian";    # Default folder for new synced folders
          configDir = "/home/xhos/obsidian/.config/syncthing";   # Folder for Syncthing's settings and keys
      };
  };
}