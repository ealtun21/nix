{ pkgs, inputs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    audacity
    chromium
    telegram-desktop
    obs-studio
    kdenlive
    gparted
    zoom-us
    polymc
    helix
    mosh

    # Coding stuff
    gnumake
    just
    gcc
    nodejs
    python
    (python3.withPackages (ps: with ps; [ requests ]))

    # CLI utils
    neofetch
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
    scrot
    ffmpeg
    light
    lux
    mediainfo
    ranger
    zram-generator
    cava
    zip
    ntfs3g
    yt-dlp
    brightnessctl
    swww
    openssl
    lazygit
    bluez
    bluez-tools

    # GUI utils
    feh
    imv
    dmenu
    screenkey
    gromit-mpx

    # Xorg stuff
    #xterm
    #xclip
    #xorg.xbacklight

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    herbstluftwm
    hyprland
    seatd
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU stuff
    amdvlk
    rocm-opencl-icd
    glaxnimate

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy

    # Other
    home-manager
    spice-vdagent
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt5ct
    libsForQt5.breeze-icons
    numix-icon-theme-circle
    catppuccin-papirus-folders
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kde
    catppuccin-qt5ct
    pkgs.vesktop
    vscode
    webcord-vencord
    chromedriver
    openconnect
    teams-for-linux
    pavucontrol
    easyeffects
    gvfs
    xorg.xauth
    xorg.xinit
    libinput
    remmina
    awesome

    lm_sensors
    bc
    jetbrains.rust-rover
    jetbrains.idea-community-bin
    jetbrains.pycharm-community-bin

    inputs.kuvpn.packages.${pkgs.system}.default

    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    #docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev

    (callPackage ./cursorsh.nix {})
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

}
