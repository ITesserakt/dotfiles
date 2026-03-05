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
      };

      home.file = {
        "${config.xdg.configHome}/nushell/custom.nu".source = ./custom.nu;
        "${config.xdg.configHome}/nushell/completion.nu".source = ./completion.nu;
        "${config.xdg.configHome}/nushell/extra.nu".source = ./extra.nu;
      };
    };
}
