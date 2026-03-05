{ config, ... }:
{
  flake.homeModules.hyprpaper =
    { pkgs, ... }:
    {
      services.hyprpaper = {
        enable = true;
        settings = {
          ipc = true;
          splash = true;
          preload = map (it: "${it}") (pkgs.lib.fileset.toList config.flake.meta.wallpapers);
        };
      };
    };
}
