# { config, ... }: {
#   programs.ssh = {
#     enable = true;
#     matchBlocks = {
#       "somehost" = {
#         host = "somehost";
#         hostname = "somename";
#         identityFile = [ "~/.ssh/somekey" ];
#       };
#     };
#   };
# }
# it's broken since 2018 apparently
# https://github.com/nix-community/home-manager/issues/322