{ inputs, ... }:
{
  flake.homeModules.pomme =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.eza.enableNushellIntegration = true;

      programs.git.settings.user = {
        name = "ITesserakt";
        email = "potryas85@mail.ru";
      };

      stylix.targets.zen-browser.profileNames = [ "tp6i6jfo.Default Profile" ];
      stylix.targets.zen-browser.enable = false;
      programs.zen-browser.extraPrefs = ''
        lockPref("media.gmp-widevinecdm.version", "system-installed");
        lockPref("media.gmp-widevinecdm.visible", true);
        lockPref("media.gmp-widevinecdm.enabled", true);
        lockPref("media.gmp-widevinecdm.autoupdate", false);
        lockPref("media.eme.enabled", true);
        lockPref("media.eme.encrypted-media-encryption-scheme.enabled", true);
      '';
      programs.zen-browser.package =
        let
          system = pkgs.stdenv.hostPlatform.system;
          zen-browser = inputs.zen-browser.packages.${system}.twilight;
        in
        zen-browser.overrideAttrs (prev: {
          buildCommand =
            let
              widevineCdmDir = "${pkgs.widevine-cdm}/share/google/chrome/WidevineCdm";
              widevineOutDir = "$out/gmp-widevinecdm/system-installed";
            in
            prev.buildCommand
            + ''
              mkdir -p "${widevineOutDir}";
              ln -s "${widevineCdmDir}/_platform_specific/linux_arm64/libwidevinecdm.so" "${widevineOutDir}/libwidevinecdm.so"
              ln -s "${widevineCdmDir}/manifest.json" "${widevineOutDir}/manifest.json"
              wrapProgram "$oldExe" --set MOZ_GMP_PATH "${widevineOutDir}"
            '';
        });

      wayland.windowManager.hyprland.settings = {
        config.input.touchpad = {
          disable_while_typing = true;
          clickfinger_behavior = true;
          tap_to_click = false;
        };
      };

      programs.noctalia.settings = lib.mapAttrsRecursive (_: value: lib.mkForce value) {
        bar.default = {
          center = [ ];
          end = [
            "media"
            "tray"
            "keyboard_layout"
            "battery"
            "volume"
            "brightness"
            "notifications"
            "control-center"
            "clock"
          ];
          margin_ends = 12;
          thickness = 36;
          background_opacity = 0.6;
          margin_edge = 6;
          widget_spacing = 15;
        };

        lockscreen_widgets.widget = {
          "lockscreen-login-box@eDP-1".cx = 960.0;
          "lockscreen-widget-0000000000000001".cx = 960.0;
          "lockscreen-widget-0000000000000001".settings.clock_style = "analog";
          "lockscreen-widget-0000000000000002".cx = 1632.0;
          "lockscreen-widget-0000000000000003".cx = 1632.0;
        };

        widget.clock.anchor = false;
        widget.clock.format = "{:%H:%M %a, %b. %d}";

        widget.media.hide_when_no_media = true;

        widget.temp.stat = "cpu_usage";
      };

      # programs.noctalia-shell.settings = {
      #   bar.barType = lib.mkForce "floating";
      #   bar.density = "comfortable";
      #   bar.contentPadding = 10;
      #   bar.widgets.center = lib.mkForce [ ];
      #   bar.widgets.left = lib.mkForce [
      #     {
      #       id = "plugin:workspace-overview";

      #     }
      #     {
      #       id = "Workspace";
      #       labelMode = "name";
      #     }
      #     {
      #       id = "SystemMonitor";
      #       diskPath = "/";
      #       compactMode = false;
      #       showCpuTemp = false;
      #       useMonospaceFont = false;
      #     }
      #   ];
      #   bar.widgets.right = lib.mkForce [
      #     {
      #       id = "Tray";
      #       colorizeIcons = false;
      #       drawerEnabled = false;
      #       hidePassive = false;
      #       chevronColor = "none";
      #     }
      #     {
      #       id = "MediaMini";
      #       showVisualizer = false;
      #       showProgressRing = false;
      #       showAlbumArt = false;
      #     }
      #     {
      #       id = "KeyboardLayout";
      #       displayMode = "forceOpen";
      #     }
      #     {
      #       id = "Battery";
      #       displayMode = "graphic";
      #       showNoctaliaPerformance = true;
      #       showPowerProfiles = true;
      #     }
      #     {
      #       id = "Volume";
      #       displayMode = "onhover";
      #     }
      #     {
      #       id = "Brightness";
      #       displayMode = "alwaysShow";
      #     }
      #     {
      #       id = "NotificationHistory";
      #     }
      #     {
      #       id = "ControlCenter";
      #     }
      #     {
      #       id = "Clock";
      #     }
      #   ];

      #   ui.panelBackgroundOpacity = lib.mkForce 0.6;

      #   general.forceBlackScreenCorners = true;

      #   idle.enabled = true;
      # };
    };
}
