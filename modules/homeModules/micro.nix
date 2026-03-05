{ lib, ... }:
{
  flake.homeModules.micro.programs.micro = {
    enable = true;
    settings = {
      mkparents = true;
      pluginrepos = [ "https://raw.githubusercontent.com/chykcha3/micro-plugin-latex/main/repo.json" ];
      lsp.server = builtins.concatStringsSep "," (
        lib.mapAttrsToList (name: value: "${name}=${value}") {
          python = "pylsp";
          rust = "rust-analyzer";
          latex = "texlab run";
        }
      );
    };
  };
}
