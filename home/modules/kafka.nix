{ config, pkgs, ... }:

{
  pkgs.rdkafka = {
    enable = true;
  };
}
