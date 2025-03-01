{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 30;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "custom/weather" "sway/window" ];
        modules-right = [
          "custom/media"
          "network"
          "cpu"
          "temperature"
          "sway/language"
          "pulseaudio"
          "tray"
          "clock#date"
          "clock#time"
        ];

        "clock#time" = {
          interval = 1;
          format = "{:%H:%M:%S}";
          tooltip = true;
        };
        "clock#date" = {
          interval = 10;
          format = "  {:%e %b %Y}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };
        "cpu" = {
          interval = 5;
          format = "  {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        "sway/language" = {
          "format" = "{variant}";
          "on-click" = "swaymsg input type:keyboard xkb_switch_layout next";
        };
        memory = {
          interval = 5;
          format = "  {}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        network = {
          interval = 5;
          "format-ethernet" = "  {ifname}: {ipaddr}/{cidr}";
          "format-disconnected" = "⚠  Disconnected";
          "tooltip-format" = "{ifname}: {ipaddr}";
        };
        pulseaudio = {
          "scroll-step" = 2;
          "format" = "{icon}  {volume}%";
          "format-muted" = "";
          "format-icons" = {
            "default" = [ "" "" ];
          };
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        temperature = {
          "critical-threshold" = 80;
          "interval" = 5;
          "format" = "{icon}  {temperatureC}°C";
          "format-icons" = [ "" "" ];
          "tooltip" = true;
        };
        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };
        "custom/weather" = {
          "format" = "{}° ";
          "tooltip" = true;
          "interval" = 3600;
          "exec" = "wttrbar --location Bonn";
          "return-type" = "json";
        };
      };
    };
    style = /* css */ ''
      @define-color bg #282828;
      @define-color fg #ebdbb2;
      @define-color yellow #fabd2f;
      @define-color red #fb4934;
      @define-color orange #fe8019;
      @define-color green #8ec07c;
      @define-color blue #83a598;
      @define-color gray #928374;

      #waybar {
          background: @bg;
          color: @fg;
          font-family: JetBrains Mono Nerd Font, Cantarell, Noto Sans, sans-serif;
          font-size: 13px;
      }

      #battery.warning { color: @orange; }
      #battery.critical { color: @red; }
      #clock { font-weight: bold; color: @yellow; }
      #cpu.warning { color: @orange; }
      #cpu.critical { color: @red; }
      #memory.warning { color: @orange; }
      #memory.critical { color: @red; }
      #network { color: @blue; }
      #network.disconnected { color: @orange; }
      #pulseaudio { color: @green; }
      #pulseaudio.muted { color: @gray; }
      #temperature { color: @fg; }
      #temperature.critical { color: @red; }
      #workspaces button { color: @gray; }
      #workspaces button.focused { border-color: @blue; color: white; background-color: @blue; }
      #workspaces button.urgent { border-color: @red; color: @red; }
      #custom-media { color: @green; }
      #tray { color: @fg; }
      #window { font-weight: bold; color: @fg; }
    '';
  };
}
