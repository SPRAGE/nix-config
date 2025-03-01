{ config, pkgs, ... }:

{
  # Enable Kitty terminal
  programs.kitty = {
    enable = true;
    extraConfig = ''
      # Gruvbox Dark Theme
      include current-theme.conf

      # Font settings
      font_family      FiraCode Nerd Font
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      font_size        10.5
      adjust_line_height  1
      adjust_column_width 1

      # Scrollback & Bell settings
      scrollback_lines 10000
      enable_audio_bell no
      visual_bell_color #282828

      # Ligatures & Cursor
      enable_ligatures always
      cursor_shape block
      cursor_blink_interval 0.5

      # Window transparency (optional)
      background_opacity 0.9

      # Performance tuning
      enable_audio_bell no
      repaint_delay 8
      input_delay 3
      sync_to_monitor yes
    '';

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
    };
  };

  # Set the Gruvbox theme
  home.file."current-theme.conf".source = builtins.fetchurl {
    url =   "https://raw.githubusercontent.com/dexpota/kitty-themes/refs/heads/master/themes/gruvbox_dark.conf";
    sha256 = "1il8jbq7xkdqz789jc1b0hxcdg5d5h1hl5x2m6rgmy4yg55p7cws"; # Run nix-prefetch-url to get the correct hash
  };

  # Install Nerd Fonts (for better icons)
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerdfonts
  ];
}
