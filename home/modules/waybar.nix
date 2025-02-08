{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "battery" "network" "pulseaudio" "tray" ];

      "clock" = {
        format = "{:%H:%M:%S}";
        tooltip-format = "{:%A, %d %B %Y}";
        interval = 1;
      };


      "cpu" = {
        format = " {usage}%";
      };

      "memory" = {
        format = " {}%";
      };

      "network" = {
        format-wifi = " {signalStrength}%";
        format-ethernet = " {ipaddr}";
        format-disconnected = " Disconnected";
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = "Mute";
        format-icons = [ "" "" "" ];
      };

      "tray" = {
        spacing = 30;
      };
    }];

    style = ''
      * {
        border: none;
        border-radius: 0px;
        font-family: "Fantasque Sans Mono", "monospace";
        font-size: 14px;
      }

      window#waybar {
        background: rgba(40, 40, 40, 0.95);
        color: white;
      }

      #clock {
        color: #ffcc00;
      }

      #battery {
        color: #ff8800;
      }

      #cpu, #memory {
        color: #88ccff;
      }

      #network {
        color: #66ff66;
      }

      #pulseaudio {
        color: #ff66ff;
      }

      #tray {
        color: white;
      }
    '';
  };

}

