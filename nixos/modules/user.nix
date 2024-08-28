{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.bash;

    users.gabechu = {
      isNormalUser = true;
      description = "gabechu";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  # services.getty.autologinUser = "gabechu";
}
