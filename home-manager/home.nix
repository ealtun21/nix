{

  imports = [
    ./fish.nix
    ./modules/bundle.nix
  ];

  home = {
    username = "gabechu";
    homeDirectory = "/home/gabechu";
    stateVersion = "23.11";
  };

  catppuccin.enable = true;
}
