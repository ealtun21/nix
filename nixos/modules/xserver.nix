{
  services.xserver = {
    enable = true;
    displayManager = {
       autoLogin.enable = false;
       autoLogin.user = "nyverin";
       lightdm.enable = true;
    };

    displayManager.startx.enable = true;

    layout = "us";
    xkbVariant = "";

    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad.accelProfile = "flat";
    };

    videoDrivers = [ "amdgpu" ];
    deviceSection = ''Option "TearFree" "True"'';
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
  };
}
