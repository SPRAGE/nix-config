{ config, pkgs, ... }:

{
  # # Enable Greetd (Minimal Login Manager)
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.gtkgreet}/bin/gtkgreet";
    };
  };

  # Install Sway, Waybar, and Dependencies System-wide
  environment.systemPackages = with pkgs; [
    sway
    waybar
    dmenu # Optional: Launcher
    alacritty # Optional: Terminal
    grim slurp # Screenshots
    wl-clipboard # Clipboard support
    mako # Notifications
    gtkgreet # GTK Greeter
  ];

  # Enable seatd for Wayland session management
  services.seatd.enable = true;

}

