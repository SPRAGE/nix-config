{
  config,
  pkgs,
  lib,
  ...
}: {
  options.modules.docker = {
    enable = lib.mkEnableOption "Docker rootless setup";
  };

  config = lib.mkIf config.modules.docker.enable {
    home.packages = with pkgs; [
      docker-client
      docker-compose
    ];

    # Add user to docker group (though not strictly necessary for rootless)
    home.extraActivationPath = [ pkgs.docker-client ];

    # Setup systemd user service for rootless docker
    systemd.user.services.docker-rootless = {
      Unit = {
        Description = "Docker Application Container Engine (Rootless)";
        Documentation = ["https://docs.docker.com/engine/security/rootless/"];
        After = [ "network.target" "local-fs.target" ];
      };

      Service = {
        Environment = [
          "PATH=${lib.makeBinPath [pkgs.docker-client pkgs.fuse-overlayfs pkgs.runc]}"
          "DOCKER_HOST=unix:///run/user/$UID/docker.sock"
        ];
        ExecStart = "${pkgs.docker-client}/bin/dockerd-rootless.sh --experimental";
        ExecReload = "${pkgs.coreutils}/bin/kill -s HUP $MAINPID";
        TimeoutSec = 0;
        Restart = "on-failure";
        RestartSec = 2;
        StartLimitBurst = 3;
        StartLimitInterval = 60;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    # Set environment variables for rootless Docker
    home.sessionVariables = {
      DOCKER_HOST = "unix:///run/user/$UID/docker.sock";
    };

    # Create required directories
    home.activation.dockerRootlessSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.local/share/docker
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.config/docker
    '';

    # Add shell aliases for convenience
    programs.bash.shellAliases = {
      dps = "docker ps";
      dimg = "docker images";
      drun = "docker run";
      dexec = "docker exec -it";
      dcomp = "docker-compose";
    };

    # Optional: Add fish shell aliases if using fish
    programs.fish.shellAliases = {
      dps = "docker ps";
      dimg = "docker images";
      drun = "docker run";
      dexec = "docker exec -it";
      dcomp = "docker-compose";
    };
  };
}
