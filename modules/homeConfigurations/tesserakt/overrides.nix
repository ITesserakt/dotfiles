{
  flake.homeModules.tesserakt =
    { pkgs, lib, ... }:
    {
      programs.nushell = {
        extraConfig = ''
          source ~/.oh-my-posh.nu
        '';

        shellAliases.micro = lib.getExe pkgs.helix;
      };

      programs.git.settings.user = {
        name = "ITesserakt";
        email = "potryas85@mail.ru";
      };

      programs.eza.enableNushellIntegration = true;

      services.hypridle.settings.general.lock_cmd = "noctalia-shell ipc call lockScreen lock";

      stylix.targets.zen-browser.profileNames = [ "lekmj3mk.Default Profile" ];
    };
}
