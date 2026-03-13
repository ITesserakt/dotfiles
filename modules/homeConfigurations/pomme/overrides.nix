{
  flake.homeModules.pomme = { pkgs, lib, ... }: {
    programs.nushell.shellAliases = {
      micro = lib.getExe pkgs.helix;
    };

    programs.eza.enableNushellIntegration = true;

    programs.git.settings.user = {
      name = "ITesserakt";
      email = "potryas85@mail.ru";
    };
  };
}
