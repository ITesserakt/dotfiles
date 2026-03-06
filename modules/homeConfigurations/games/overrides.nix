{
  flake.homeModules.games =
    { pkgs, lib, ... }:
    {
      programs.fish.shellAliases = {
        micro = lib.getExe pkgs.helix;
      };

      services.hypridle.settings.general.lock_cmd = "noctalia-shell ipc call lockScreen lock";
    };
}
