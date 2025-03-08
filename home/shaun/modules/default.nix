
{
  imports = [
    ../../modules/waybar.nix
    ../../modules/fonts.nix
    ../../modules/kitty.nix
    # ../../modules/hyprland.nix
    ../../modules/greetd.nix
    ../../modules/sway.nix
    ../../modules/nix-flake-templates

    ../../modules/neovim
    ./git-config.nix
  ];
}
