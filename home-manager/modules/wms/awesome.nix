{config, ...}: {
  # Import the awesomewm configuration
  home.file."${config.xdg.configHome}/awesome/rc.lua".source = ./awesome/rc.lua;
  home.file."${config.xdg.configHome}/awesome/themes".source = ./awesome/themes;
  home.file."${config.xdg.configHome}/awesome/freedesktop".source = ./awesome/freedesktop;
  home.file."${config.xdg.configHome}/awesome/lain".source = ./awesome/lain;
}