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

    stylix.targets.zen-browser.profileNames = [ "tp6i6jfo.Default Profile" ];
    stylix.targets.zen-browser.enable = false;

    wayland.windowManager.hyprland.settings = {
      input.touchpad = {
        disable_while_typing = true;
        clickfinger_behavior = true;
        tap-to-click = false;
      };
    };
  };
}
