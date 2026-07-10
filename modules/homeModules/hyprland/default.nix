{ inputs, ... }:
{
  flake.homeModules.hyprland =
    {
      config,
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
        (hyprshot.override {
          hyprland = hyprland-pkgs.hyprland;
        })
      ];
      home.sessionVariables = {
        HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };

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
          }
          
          require("dynamic")
        '';
        settings.config =
          let
            colors = config.stylix.base16.mkSchemeAttrs config.stylix.base16Scheme;
            rgb = color: "rgb(${color})";
            rgba = color: alpha: "rgba(${color}${alpha})";
          in
          {
            # FIXME: stylix module does not put those attrs inside `config`.
            decoration.shadow.color = rgba colors.base00 "99";
            general = {
              "col.active_border" = rgb colors.base0D;
              "col.inactive_border" = rgb colors.base03;
            };
            group = {
              "col.border_inactive" = rgb colors.base03;
              "col.border_active" = rgb colors.base0D;
              "col.border_locked_active" = rgb colors.base0C;

              groupbar = {
                text_color = rgb colors.base05;
                "col.active" = rgb colors.base0D;
                "col.inactive" = rgb colors.base03;
              };
            };
            misc.background_color = rgb colors.base00;
          };
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
