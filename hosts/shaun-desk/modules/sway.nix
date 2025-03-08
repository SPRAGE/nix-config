{ config, lib, pkgs, osConfig, ... }:
{

  programs.bash.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "''\${XDG_VTNR:-0}" -eq 1 ]; then
      exec sway
    fi
  '';

  home.packages = with pkgs; [
    gamescope
    playerctl
    dconf
    glib # gsettings
    swaylock
    swayidle
    # grim # screenshot functionality
    # slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    xdg-utils
    waybar
    rofi-wayland-unwrapped
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "Gruvbox";
    };
    # Vcursor = {
    #   package = pkgs.gruvbox-gtk-theme;
    #   name = "Grubox-icons";
    # };
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
      size = 10;
    };
  };
  xdg.cursorTheme = {
    package = pkgs.gruvbox-gtk-theme;
    name = "Grubox-icons";
    size = 24; # You can adjust this value
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
    ];
    timeouts = [
      {
        timeout = 1800;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
      {
        timeout = 1800;
        command = ''${pkgs.sway}/bin/swaymsg "output * power off" '';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway-unwrapped;
    checkConfig = false;
    wrapperFeatures = {
      gtk = true;
    };

    config = {
      modifier = "Mod4";
      terminal = "kitty";
      defaultWorkspace = "workspace number 1";
      menu = "rofi -modi window -show drun";


      # input = {
      #   "12815:20550:USB_HID_GMMK_Pro" = {
      #     xkb_layout = "gb,us";
      #     xkb_variant = ",dvp";
      #     xkb_options = "caps:escape,compose:ralt,grp:ctrls_toggle";
      #   };
      #   "1133:49305:Logitech_G502_X" = {
      #     accel_profile = "flat";
      #     pointer_accel = "-0.8";
      #   };
      #   "1:1:AT_Translated_Set_2_keyboard" = {
      #     xkb_layout = "gb,us";
      #     xkb_variant = ",dvp";
      #     xkb_options = "caps:escape,compose:ralt,grp:ctrls_toggle";
      #   };
      # };

      output.DP-3 = {
      mode = "2560x1080@75Hz";  # Resolution and refresh rate
      position = "0,0";         # Main monitor
      scale = "1";
      allow_tearing = "yes";
    };

    output.DP-2 = {
      mode = "1920x1080@60Hz";
      position = "-1080,-600";  # Offset similar to Hyprland
      scale = "1";
      transform = "270";         # Adjust this based on how Hyprland's transform 1 corresponds
    };

    output.HDMI-A-1 = {
      mode = "1920x1080@60Hz";
      position = "2560,-100";   # Same placement as Hyprland
      scale = "1";
    };
    workspaceOutputAssign = [
      { workspace = "2"; output = "DP-3"; }
      { workspace = "1"; output = "DP-2"; }
      { workspace = "3"; output = "HDMI-A-1"; }
    ];
    startup = [
      { command = "swaymsg input type:keyboard xkb_options 'numpad:mac'"; }
      { command = "swaymsg focus_follows_mouse no"; }
    ];

      modes =
        let
          inherit (config.wayland.windowManager.sway.config) modifier;
        in
        lib.mkOptionDefault
          {
            gaming = {
              "${modifier}+shift+g" = "exec '~/.config/sway/mode_default.sh'";
              "${modifier}+f" = "fullscreen toggle";
              "XF86AudioRaiseVolume" = "exec --no-startup-id 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
              "XF86AudioLowerVolume" = "exec --no-startup-id 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
              "XF86AudioMute" = "exec --no-startup-id 'kill -s USR1 $(ps -C gpu-screen-recorder)'";
            };
          };

      keybindings =
        let
          inherit (config.wayland.windowManager.sway.config) modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
          "Print" = "exec 'mkdir -p ~/Downloads; FILENAME=\"screenshot-`date +%F-%T`\"; grim -g \"$(slurp)\" ~/Downloads/$FILENAME.png '";
          "${modifier}+Print" = "exec 'grim -g \"$(slurp -d)\" - | wl-copy";
          "${modifier}+period" = "exec 'playerctl -p ncspot next'";
          "${modifier}+comma" = "exec 'playerctl -p ncspot previous'";
          "${modifier}+shift+g" = "exec '~/.config/sway/mode_gaming.sh'";
          "${modifier}+o" = "exec 'swaymsg [app_id=\"obsidian\"] scratchpad show";
          "${modifier}+m" = "exec 'swaymsg [title=\"ncspot\"] scratchpad show";
          "${modifier}+shift+y" = "exec 'swaylock -f -c 000000'";
          "${config.wayland.windowManager.sway.config.modifier}+1" = "workspace number 1";
          "${config.wayland.windowManager.sway.config.modifier}+2" = "workspace number 2";
          "${config.wayland.windowManager.sway.config.modifier}+3" = "workspace number 3";
          "${config.wayland.windowManager.sway.config.modifier}+4" = "workspace number 4";
          "${config.wayland.windowManager.sway.config.modifier}+5" = "workspace number 5";
          "${config.wayland.windowManager.sway.config.modifier}+6" = "workspace number 6";
          "${config.wayland.windowManager.sway.config.modifier}+7" = "workspace number 7";
          "${config.wayland.windowManager.sway.config.modifier}+8" = "workspace number 8";
          "${config.wayland.windowManager.sway.config.modifier}+9" = "workspace number 9";
          "${config.wayland.windowManager.sway.config.modifier}+0" = "workspace number 10";

        };

      bars = [
        {
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = { background = "#32323200"; border = "#32323200"; text = "#5c5c5c"; };
          };
          position = "top";
          command = "waybar";
        }
      ];
      window.titlebar = false;
    };
  };


  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    ignoreTimeout = true;
    extraConfig = /*toml*/ ''
      background-color=#282a36
      text-color=#ffffff
      border-color=#282a36

      [urgency=low]
      border-color=#282a36

      [urgency=normal]
      border-color=#f1fa8c

      [urgency=high]
      border-color=#ff5555
    '';
  };


  home.file."./.config/sway/mode_gaming.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      swaymsg 'mode gaming'
      # setxkbmap -option -option caps:none

      game=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .name')

      gpu-screen-recorder -w screen -f 60 -c mp4 -a "alsa_output.usb-Universal_Audio_Volt_1_23032036038581-00.analog-stereo.monitor" -r 30 -o "$HOME/Videos/replay/$game"
    '';
  };

  home.file."./.config/sway/mode_default.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      swaymsg 'mode default'
      # setxkbmap -option -option caps:escape
      pkill gpu-screen-reco
    '';
  };


}
