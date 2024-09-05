{ inputs, pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  disabledModules = [
    ./modules/xserver.nix
  ];

  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblock
       hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
       betterGenres
       volumePercentage
       playingSource
       songStats
       powerBar
     ];
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";
   };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  security.sudo.extraRules= [
    {  users = [ "nyverin" ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  services.udisks2.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  services.greetd = {
    enable = true;
    settings = {
     default_session.command = ''
      ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --time \
        --asterisks \
        --user-menu \
        --cmd hyprland
    '';
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprland
    dwm
  '';


  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.tumbler.enable = true; 
  services.gvfs.enable = true; # Mount, trash, and other functionalities

  environment.variables.GTK_THEME = "catppuccin-mocha-blue-standard+normal";
  environment.variables.XCURSOR_THEME = "catppuccin-mocha-blue-cursors";
  environment.variables.XCURSOR_SIZE = "24";
  environment.variables.HYPRCURSOR_THEME = "catppuccin-mocha-blue-cursors";
  environment.variables.HYPRCURSOR_SIZE = "24";

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Enable dwm.
  services.xserver.windowManager.dwm.enable = true;


  nixpkgs.overlays = [
  # Minecrraft:
  inputs.polymc.overlay

  (self: super: {
    # Configure dwm.
    dwm = super.dwm.overrideAttrs (oldAttrs: rec {
      patches = [
        (super.fetchpatch {
          url = "https://dwm.suckless.org/patches/autostart/dwm-autostart-20210120-cb3f58a.diff";
          sha256 = "1gksmq7ad3fs25afgj8irbwcidhyzh0cmba7vkjlsmbdgrc131yp";
        })
        (super.fetchpatch {
          url = "https://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff";
          sha256 = "1lbzjr972s42x8b9j6jx82953jxjjd8qna66x5vywaibglw4pkq1";
        })
        (super.fetchpatch {
          url = "https://dwm.suckless.org/patches/fancybar/dwm-fancybar-20220527-d3f93c7.diff";
          sha256 = "1q4318676aavvx7kiwqab4wzaq5y7b1n90cskpdgx1v3nvkq4s4x";
        })
        (super.fetchpatch {
          url = "https://dwm.suckless.org/patches/alpha/dwm-alpha-20201019-61bb8b2.diff";
          sha256 = "0qymdjh7b2smbv37nrh0ifk7snm07y4hhw7yiizh6kp2kik46392";
        })
      ];
      configFile = super.writeText "config.h" (builtins.readFile ./dwm-config.h);
      postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h\n";
    });
  })];


  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.chromium}/bin/chromium";

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "Europe/Istanbul"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enabling flakes

  catppuccin.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05"; # Don't change it bro
}
