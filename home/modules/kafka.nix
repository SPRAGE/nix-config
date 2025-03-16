{ config, pkgs, ... }:

{
  programs.rdkafka = {
    enable = true;
  };
}
