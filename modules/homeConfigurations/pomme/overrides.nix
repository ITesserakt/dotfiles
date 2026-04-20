{
  flake.homeModules.pomme =
    {
      pkgs,
      lib,
      ...
    }:
    {
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

      services.linux-wallpaperengine = {
        assetsPath = ./wallpapers/assets;
        wallpapers = [
          {
            wallpaperId = "${./wallpapers/default}";
            fps = 24;
            monitor = "eDP-1";
            scaling = "fill";
          }
        ];
      };

      programs.noctalia-shell.settings = {
        bar.barType = lib.mkForce "floating";
        bar.density = "comfortable";
        bar.contentPadding = 10;
        bar.widgets.center = lib.mkForce [ ];
        bar.widgets.left = lib.mkForce [
          {
            id = "plugin:workspace-overview";

          }
          {
            id = "Workspace";
            labelMode = "name";
          }
          {
            id = "SystemMonitor";
            diskPath = "/";
            compactMode = false;
            showCpuTemp = false;
            useMonospaceFont = false;
          }
        ];
        bar.widgets.right = lib.mkForce [
          {
            id = "Tray";
            colorizeIcons = false;
            drawerEnabled = false;
            hidePassive = false;
            chevronColor = "none";
          }
          {
            id = "MediaMini";
            showVisualizer = true;
            showProgressRing = false;
            showAlbumArt = false;
          }
          {
            id = "KeyboardLayout";
            displayMode = "forceOpen";
          }
          {
            id = "Battery";
            displayMode = "graphic";
            showNoctaliaPerformance = true;
            showPowerProfiles = true;
          }
          {
            id = "Volume";
            displayMode = "onhover";
          }
          {
            id = "Brightness";
            displayMode = "alwaysShow";
          }
          {
            id = "NotificationHistory";
          }
          {
            id = "ControlCenter";
          }
          {
            id = "Clock";
          }
        ];

        ui.panelBackgroundOpacity = lib.mkForce 0.6;

        general.forceBlackScreenCorners = true;

        idle.enabled = true;
      };
    };
}
