{ inputs, ... }:
{
  flake.homeModules.hyprland =
    {
      pkgs,
      lib,
      ...
    }:
    let
      hyprland-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      home.packages = with pkgs; [
        wl-clipboard
      ];

      xdg = {
        enable = lib.mkForce true;
        portal = {
          enable = lib.mkForce true;
          configPackages = [
            hyprland-pkgs.xdg-desktop-portal-hyprland
          ];
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
        };
      };

      services.hyprpolkitagent.enable = false;

      wayland.windowManager.hyprland = {
        enable = true;
        package = hyprland-pkgs.hyprland;
        portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        systemd.enable = true;
        configType = "lua";
        extraConfig =
          # lua
          ''
            options = {
              kitty = "${lib.getExe pkgs.kitty}",
              btop = "${lib.getExe pkgs.btop}",
              wpctl = "${pkgs.wireplumber}/bin/wpctl",
              brightnessctl = "${lib.getExe pkgs.brightnessctl}",
              playerctl = "${lib.getExe pkgs.playerctl}",
              notify = "${lib.getExe pkgs.libnotify}"
            }

            require("dynamic")
          '';
        settings.bind =
          let
            mkBind = bind: action: mkBindWithOpts bind action { };
            mkBindWithOpts = bind: action: opts: {
              _args = [
                (if lib.isList bind then lib.concatStringsSep " + " bind else bind)
                (lib.generators.mkLuaInline action)
                opts
              ];
            };
          in
          [
            (mkBind [ "SUPER" "3" ] ''hl.dsp.exec_cmd("${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}")'')
            (mkBind [ "SUPER" "4" ] ''hl.dsp.exec_cmd("${lib.getExe pkgs.kitty}")'')
            (mkBindWithOpts "XF86AudioRaiseVolume"
              ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")''
              {
                locked = true;
                repeating = true;
              }
            )
            (mkBindWithOpts "XF86AudioLowerVolume"
              ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")''
              {
                locked = true;
                repeating = true;
              }
            )
            (mkBindWithOpts "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} s +5%")''
              {
                locked = true;
                repeating = true;
              }
            )
            (mkBindWithOpts "XF86MonBrightnessDown"
              ''hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} s 5%-")''
              {
                locked = true;
                repeating = true;
              }
            )
            (mkBindWithOpts "XF86AudioMute"
              ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")''
              { locked = true; }
            )
            (mkBindWithOpts "XF86AudioMicMute"
              ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")''
              { locked = true; }
            )
            (mkBindWithOpts "XF86AudioPlay" ''hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} play-pause")'' {
              locked = true;
            })
            (mkBindWithOpts "XF86AudioPrev" ''hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} previous")'' {
              locked = true;
            })
            (mkBindWithOpts "XF86AudioNext" ''hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} next")'' {
              locked = true;
            })
          ];
        plugins = [ ];
      };
    };
}
