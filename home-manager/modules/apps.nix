{ pkgs, config, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.alacritty = {
    enable = true;
    settings = {

      font = {
        size = 13.0;
        # draw_bold_text_with_bright_colors = true;
        normal = {
          family = "JetBrains Mono";
          style = "Bold";
        };
      };

    };
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrains Mono Bold";
    shellIntegration.enableFishIntegration = true;
    settings = {
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      enable_audio_bell = "no";
      window_padding_width = 12;
      shell = "${pkgs.fish}/bin/fish";
      font_size = 13;
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      log = {
        enabled = false;
      };
      manager = {
        show_hidden = false;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
    };

  };

  programs.bat = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      function starship_transient_prompt_func
        starship module character
      end
      starship init fish | source
      enable_transience
    '';
  };

  programs.fuzzel = {
    enable = true;
    catppuccin.enable = false;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:weight=bold:size=14";
        line-height = 25;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "kitty";
        prompt = "' ➜  '";
        icon-theme = "Papirus-Dark";
        layer = "top";
        lines = 10;
        width = 35;
        horizontal-pad = 25;
        inner-pad = 5;
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "89b4faaa";
        selection-match = "f38ba8ff";
        selection-text = "cdd6f4ff";
        border = "89b4faff";
      };
      border = {
        radius = 10;
        width = 3;
      };
    };
  };

  services.mako = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "gabechu";
    userEmail = "mbudak21@ku.edu.tr";
  };

  programs.htop = {
    enable = true;
    settings = {
      tree_view = 1;
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      editor.lsp = {
        display-inlay-hints = true;
      };
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.statusline = {
        left = [
          "mode"
          "spinner"
        ];
        center = [ "file-name" ];
        right = [
          "diagnostics"
          "selections"
          "position-percentage"
          "position"
          "file-encoding"
          "file-type"
        ];
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
  };

  programs.tmux = {
    enable = true;
  };

  programs.zellij = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    theme = {
      "*" = {
        font = "FiraCode Nerd Font Medium 14";
        bg0 = mkLiteral "#1e1e2e";
        bg1 = mkLiteral "#181825";
        bg2 = mkLiteral "#11111b";
        bg3 = mkLiteral "#b4befe";
        fg0 = mkLiteral "#cdd6f4";
        fg1 = mkLiteral "#bac2de";
        fg2 = mkLiteral "#a6adc8";
        red = mkLiteral "#f38ba8";
        green = mkLiteral "#a6e3a1";
        yellow = mkLiteral "#f9e2af";
        blue = mkLiteral "#89b4fa";
        magenta = mkLiteral "#cba6f7";
        cyan = mkLiteral "#94e2d5";

        accent = mkLiteral "@red";
        urgent = mkLiteral "@yellow";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = 0;
        padding = 0;
        spacing = 0;
      };
      "element-icon, element-text, scrollbar" = {
        cursor = mkLiteral "pointer";
      };

      "window" = {
        location = mkLiteral "center";
        width = mkLiteral "500px";

        background-color = mkLiteral "@bg1";
        border = mkLiteral "3px";
        border-color = mkLiteral "@bg3";
        border-radius = mkLiteral "6px";
      };

      "inputbar" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "4px 8px";
        children = mkLiteral "[ prompt, entry ]";

        background-color = mkLiteral "@bg0";
      };

      "icon-search, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      "icon-search" = {
        expand = mkLiteral "false";
        filename = "search-symbolic";
        size = mkLiteral "14px";
      };

      "textbox" = {
        padding = mkLiteral "4px 8px";
        background-color = mkLiteral "@bg2";
      };

      "listview" = {
        padding = mkLiteral "4px 0px";
        lines = mkLiteral "12";
        columns = mkLiteral "1";
        scrollbar = mkLiteral "false";
        fixed-height = mkLiteral "false";
        dynamic = mkLiteral "true";
      };

      "element" = {
        padding = mkLiteral "4px 8px";
        spacing = mkLiteral "8px";
      };

      "element normal urgent" = {
        text-color = mkLiteral "@urgent";
      };

      "element normal active" = {
        text-color = mkLiteral "@accent";
      };

      "element selected" = {
        text-color = mkLiteral "@bg1";
        background-color = mkLiteral "@accent";
      };

      "element selected urgent" = {
        background-color = mkLiteral "@urgent";
      };

      "element-icon" = {
        size = mkLiteral "0.8em";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
      };

      "scrollbar" = {
        handle-width = mkLiteral "0px";
        handle-color = mkLiteral "@fg2";
        padding = mkLiteral "0 4px";
      };
    };
    extraConfig = {
      modes = mkLiteral "[ combi ]";
      combi-modes = mkLiteral "[ window, drun, run ]";
    };
  };

  programs.git.delta = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
  };

  programs.starship = {
    catppuccin.enable = false;
    enable = true;
    enableFishIntegration = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };

}
