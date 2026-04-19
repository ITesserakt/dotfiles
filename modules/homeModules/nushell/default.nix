{
  flake.homeModules.nushell =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.nushell = {
        enable = true;

        configFile.text = ''
          source custom.nu
          source completion.nu
          source extra.nu
        '';

        shellAliases = {
          cat = lib.getExe pkgs.bat;
          nix-shell = "nix-shell --run nu";
        };

        plugins = with pkgs.nushellPlugins; [
          gstat
          polars
        ];

        environmentVariables = config.home.sessionVariables // {
          # nushell somehow removes this var
          NH_FLAKE = "github:ITesserakt/dotfiles";
          SSH_AUTH_SOCK = if config.services.ssh-agent.enable then "$XDG_RUNTIME_DIR/ssh-agent.socket" else null;
        };
      };

      home.file =
        let
          nushellConfigHome = "${config.xdg.configHome}/nushell";
        in
        {
          "${nushellConfigHome}/custom.nu".source = ./custom.nu;
          "${nushellConfigHome}/completion.nu".source = ./completion.nu;
          "${nushellConfigHome}/extra.nu".source = ./extra.nu;
        };
    };
}
