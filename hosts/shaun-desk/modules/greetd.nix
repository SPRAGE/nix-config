{ config, pkgs, ... }:

{
  # Enable Greetd (Minimal Wayland Login Manager)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";
        user = "greeter";  # Use a dedicated user
      };
    };
  };

  # Install System-wide Wayland Environment
  environment.systemPackages = with pkgs; [
    sway
    waybar
    dmenu  # Optional: Launcher
    alacritty  # Optional: Terminal
    grim slurp  # Screenshots
    wl-clipboard  # Clipboard support
    mako  # Notifications
    greetd.gtkgreet  # GTK-based Greeter for Greetd
  ];

  # Enable seatd (Wayland Session Management)
  services.seatd.enable = true;

  # Ensure the 'greeter' user exists and has permissions
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
  };

  users.groups.greeter = {};

  # Fix permissions for seatd
  users.groups.seat.members = [ "greeter" ];
}

