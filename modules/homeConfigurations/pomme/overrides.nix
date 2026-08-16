{ inputs, ... }: {
  flake.homeModules.pomme =
    {
      pkgs,
      lib,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
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

      services.wluma.settings = {
        keyboard = [
          {
            name = "kbd";
            path = "/sys/class/leds/kbd_backlight";
          }
        ];

        output.backlight = [
          {
            name = "eDP-1";
            path = "/sys/class/backlight/apple-panel-bl";
            capturer = "none";
          }
        ];

        als.iio.path = "/sys/bus/iio/devices";
        als.iio.thresholds = {
          "0" = "night";
          "20" = "dark";
          "80" = "dim";
          "250" = "normal";
          "500" = "bright";
          "800" = "outdoors";
        };
      };

      # FIXME: add python to noctalia PATH
      #        currently, evaluation will panic with two noctalia's bin conflicting
      programs.noctalia.package =
        let
          noctalia = inputs.noctalia_v5.packages.${system}.default;
          pythonExe = baseNameOf (lib.getExe pkgs.python3);
          libs = lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib
            pkgs.zlib
          ];
          python = pkgs.symlinkJoin {
            name = "python-with-cxx";
            paths = [ pkgs.python3 ];
            nativeBuildInputs = [ pkgs.makeWrapper ];

            postBuild = ''
              rm $out/bin/${pythonExe}

              makeWrapper ${lib.getExe pkgs.python3} $out/bin/${pythonExe} \
                --prefix LD_LIBRARY_PATH : ${libs}
            '';
          };
          env = lib.makeBinPath [
            python
            pkgs.gpu-screen-recorder
            pkgs.evtest
          ];
        in
        pkgs.symlinkJoin {
          name = "noctalia-wrapped";
          paths = [ noctalia ];
          meta.mainProgram = "noctalia";
          nativeBuildInputs = [ pkgs.makeWrapper ];

          postBuild = ''
            rm $out/bin/noctalia

            makeWrapper ${lib.getExe noctalia} $out/bin/noctalia \
              --prefix PATH : ${env}
          '';
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
        widget.clock.format = "{:%H:%M %a; %b. %d}";

        widget.media.hide_when_no_media = true;

        widget.temp.stat = "cpu_usage";
      };
    };
}
