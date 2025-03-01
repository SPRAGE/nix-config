{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "shaun";
    userEmail = "shauna.pai@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      credential.helper = "cache --timeout=3600";
      core.editor = "nvim";
    };
  };
}

