{
  flake.homeModules.apfel = { lib, pkgs, ... }: {
    stylix.targets.zen-browser.profileNames = [ "bdnewxxm.Default (twilight)" ];
    stylix.targets.zen-browser.enable = false;

    programs.kitty.settings.background_blur = 40;
    programs.kitty.settings.macos_option_as_alt = "both";
    programs.kitty.settings.shell = ''${lib.getExe pkgs.fish}'';
    
    programs.git.settings.user = {
      name = "ITesserakt";
      email = "potryas85@mail.ru";
    };

    programs.eza.enableNushellIntegration = true;

    stylix.icons.enable = lib.mkForce false;
    stylix.targets.zed.fonts.override.monospace.name = "Monaspace Krypton Frozen";
  };
}
