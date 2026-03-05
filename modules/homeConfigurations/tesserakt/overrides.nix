{
  flake.homeModules.tesserakt = { pkgs, lib, ... }: {
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
  };
}
