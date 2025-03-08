{ config, pkgs, ... }:

{
  # Enable SDDM (Wayland-compatible display manager)
  services.displayManager.sddm.enable = true;

  # Set SDDM to start Wayland sessions first
  services.displayManager.sddm.wayland.enable = true;

  # Install system-wide Wayland packages
  environment.systemPackages = with pkgs; [
    sway
    waybar
    dmenu
    alacritty
    grim slurp
    wl-clipboard
    mako
  ];

  # Enable seatd for session management (recommended for Wayland)
  services.seatd.enable = true;
}

