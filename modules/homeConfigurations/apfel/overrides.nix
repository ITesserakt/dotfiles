{
  flake.homeModules.apfel = { lib, pkgs, ... }: {
    stylix.targets.zen-browser.profileNames = [ "bdnewxxm.Default (twilight)" ];
    # stylix.targets.zen-browser.enable = false;

    programs.nushell = {
      shellAliases.micro = lib.getExe pkgs.helix;
    };

    programs.kitty.settings.background_blur = 40;
    programs.kitty.settings.macos_option_as_alt = true;
    programs.kitty.settings.shell = ''zsh -c "nu"'';
    
    programs.git.settings.user = {
      name = "ITesserakt";
      email = "potryas85@mail.ru";
    };

    programs.eza.enableNushellIntegration = true;

    stylix.icons.enable = lib.mkForce false;
  };
}
