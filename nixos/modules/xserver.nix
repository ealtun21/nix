{
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #    default_session.command = ''
  #     ${pkgs.greetd.tuigreet}/bin/tuigreet \
  #       --time \
  #       --asterisks \
  #       --user-menu \
  #       --cmd hyprland
  #   '';
  #   };
  # };
  # 
  # environment.etc."greetd/environments".text = ''
  #   hyprland
  #   none+awesome
  # '';
  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
    };

    displayManager.startx.enable = true;

    # Set keyboard layouts and options
    xkb.layout = "us, tr";
    xkb.options = "grp:caps_toggle,shift:both_capslock_cancel";

    videoDrivers = [ "amdgpu" ];
    deviceSection = ''Option "TearFree" "True"'';
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
  };

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };
}
