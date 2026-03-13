{
  flake.homeModules.apfel = { lib, pkgs, ... }: {
    # stylix.targets.zen-browser.profileNames = [ "wtb3ki0r.Default (release)" ];
    stylix.targets.zen-browser.enable = false;

    programs.nushell = {
      extraConfig = ''
        source ~/.oh-my-posh.nu
      '';

      shellAliases.micro = lib.getExe pkgs.helix;
    };

    programs.kitty.settings.background_blur = 40;
    
    programs.git.settings.user = {
      name = "ITesserakt";
      email = "potryas85@mail.ru";
    };

    programs.eza.enableNushellIntegration = true;

    stylix.icons.enable = lib.mkForce false;

    xdg.enable = true;
  };
}
