# This is a default home.nix generated by the following home-manager command
#
# home-manager init ./

{ config, lib, pkgs, inputs, outputs, nixpkgs-unstable, ... }:

let
  # Define stable packages from nixpkgs
  stablePackages = with pkgs; [
    gh
    kitty
    firefox
    wofi
    tree
    waybar
    libreoffice-qt6
    xfce.thunar
    unzip
    rustc
    cargo
    go
    fzf
  ];

  # Define unstable packages from nixpkgs-unstable
  unstablePackages = with nixpkgs-unstable.legacyPackages.${pkgs.system}; [
    windsurf
  ];
in
{
  # Home Manager needs a bit of information about you and the paths it should manage.
  imports = [
    ./modules
  ];

  home.username = lib.mkDefault "shaun";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  # Install packages from both stable and unstable channels
  home.packages = stablePackages ++ unstablePackages;

  # This value determines the Home Manager release that your configuration is compatible with.
  # This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Example of managing dotfiles (uncomment and modify as needed)
    # ".screenrc".source = dotfiles/screenrc;
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through 'home.sessionVariables'.
  # If you don't want to manage your shell through Home Manager then you have to manually
  # source 'hm-session-vars.sh' located at:
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/shaun/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

