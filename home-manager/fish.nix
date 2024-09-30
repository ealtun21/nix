{ config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      if test -f /etc/secrets/ku.env
        source /etc/secrets/ku.env
      end

      # Set up aliases
      set flakeDir ~/nix
      alias rb "sudo nixos-rebuild switch --flake $flakeDir"
      alias upd "nix flake update $flakeDir"
      alias upg "sudo nixos-rebuild switch --upgrade --flake $flakeDir"
      alias hms "home-manager switch --flake $flakeDir"
      alias fan_boost "sudo /home/nyverin/.cargo/bin/fan_boost"
      alias meestic "/home/nyverin/.cargo/bin/meestic"
      alias timovate "/home/nyverin/.cargo/bin/timovate"
      alias conf "hx $flakeDir/nixos/configuration.nix"
      alias pkgs "hx $flakeDir/nixos/packages.nix"
      alias ll "ls -l"
      alias v "hx"
      alias se "sudoedit"
      alias ff "fastfetch"

      function fish_command_not_found --on-event fish_command_not_found
        echo "$argv: command not found"
      end
    '';

  };
}
