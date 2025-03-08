{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          export XDG_RUNTIME_DIR=/run/user/$(id -u greeter)
          export WAYLAND_DISPLAY=wayland-0
          ${pkgs.greetd.gtkgreet}/bin/gtkgreet
        '';
        user = "greeter";
      };
    };
  };

  # Ensure the 'greeter' user exists and has permissions
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    extraGroups = [ "video" "input" "seat" ]; # Ensure proper Wayland access
  };

  users.groups.greeter = {};
  users.groups.seat.members = [ "greeter" ];

  # Install necessary system packages
  environment.systemPackages = with pkgs; [
    sway
    waybar
    dmenu
    alacritty
    grim slurp
    wl-clipboard
    mako
    greetd.gtkgreet
  ];

  # Enable seatd (Wayland session management)
  services.seatd.enable = true;
}

