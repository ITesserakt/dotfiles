{ inputs, ... }:
{
  flake.nixosModules.extra-substituters = {
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
  };

  flake.homeModules.noctalia-shell_v5 = { pkgs, config, ... }: {
    imports = [
      inputs.noctalia_v5.homeModules.default
    ];

    programs.noctalia = {
      enable = true;

      settings = {
        bar.default = {
          start = [
            "workspaces"
            "temp"
            "ram"
          ];
          center = [
            "cat"
            "clock"
            "media"
            "wallpaper"
          ];
          end = [
            "tray"
            "keyboard_layout"
            "battery"
            "recorder"
            "volume"
            "brightness"
            "notifications"
            "control-center"
          ];
          radius = 16;
          margin_ends = 0;
          thickness = 32;
        };

        brightness.sync_all_monitors = true;

        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "lock-and-suspend"
          ];
          behavior.lock = {
            action = "lock";
            enabled = true;
            timeout = 600.0;
          };
          behavior.lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 900.0;
          };
          behavior.screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 660.0;
          };
        };

        location.address = "Moscow";

        lockscreen.blur_intensity = 0.7;

        lockscreen_widgets = {
          enabled = true;
          schema_version = 2;
          widget_order = [
            "lockscreen-login-box@eDP-1"
            "lockscreen-widget-0000000000000001"
            "lockscreen-widget-0000000000000002"
            "lockscreen-widget-0000000000000003"
          ];
          widget."lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 1024.0;
            cy = 1160.0;
            output = "eDP-1";
            type = "login_box";
            rotation = 0.0;
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
          };
          widget."lockscreen-widget-0000000000000001" = {
            box_height = 336.0;
            box_width = 448.0;
            cx = 1024.0;
            cy = 380.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "clock";
            settings = {
              background = false;
              circle = false;
              clock_style = "analog";
            };
          };
          widget."lockscreen-widget-0000000000000002" = {
            box_height = 144.0;
            box_width = 448.0;
            cx = 1700.0;
            cy = 968.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "weather";
            settings.show_forecast = false;
          };
          widget."lockscreen-widget-0000000000000003" = {
            box_height = 96.0;
            box_width = 448.0;
            cx = 1700.0;
            cy = 816.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "clock";
            settings.center_text = true;
            settings.format = "{:%d %m %Y}";
          };
        };

        osd.position = "top_right";
        osd.kinds.keyboard_layout = false;

        plugins.enabled = [
          "noctalia/screen_recorder"
          "noctalia/bongocat"
        ];

        shell = {
          clipboard_enabled = false;
          password_style = "random";
          polkit_agent = true;
          panel.polkit_position = "auto";
          panel.session_position = "top_right";
          screen_corners.enabled = true;
          screenshot.directory = "${config.home.homeDirectory}/Pictures/Screenshots";
        };

        theme.templates.enable_builtin_templates = false;
        theme.templates.enable_community_templates = false;

        widget = {
          cat.input_devices = [ "/dev/input/by-id/*-event-*" ];
          cat.interactive = false;
          cat.type = "noctalia-bongocat:cat";

          clock.anchor = true;

          cpu.stat = "cpu_temp";

          media.hide_album_art = true;
          media.title_scroll = "on_hover";

          recorder.type = "noctalia/screen_recorder:recorder";

          wallpaper.enabled = true;
        };
      };
    };
    home.packages = [
      inputs.noctalia_v5.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.evtest
    ];
  };

  flake.homeModules.noctalia-shell =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      home.packages =
        with pkgs;
        [
          kdePackages.qttools
          kdePackages.krdp
        ]
        ++ lib.optionals pkgs.stdenv.isx86_64 [
          pkgs.gpu-screen-recorder
        ];

      programs.noctalia-shell = {
        enable = true;
        plugins = {
          sources = [
            {
              enabled = true;
              name = "Official Noctalia Plugins";
              url = "https://github.com/noctalia-dev/noctalia-plugins";
            }
          ];
          states = builtins.listToAttrs (
            map
              (name: {
                inherit name;
                value = {
                  enabled = true;
                  sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
                };
              })
              [
                "catwalk"
                "mini-docker"
                "screen-recorder"
                "kde-connect"
                "workspace-overview"
              ]
          );
          version = 1;
        };

        pluginSettings = {
          catwalk = {
            minimumThreshold = 10;
            hideBackground = true;
          };
        };

        settings = {
          bar.showCapsule = false;
          bar.marginVertical = 5;
          bar.marginHorizontal = 11;
          bar.widgets = {
            left = [
              {
                id = "Workspace";
                labelMode = "name";
              }
              {
                id = "SystemMonitor";
                diskPath = "/";
              }
            ];
            center = [
              {
                id = "plugin:rss-feed";
              }
              {
                id = "plugin:catwalk";
              }
              {
                id = "Clock";
              }
              {
                id = "MediaMini";
              }
              {
                id = "WallpaperSelector";
              }
            ];
            right = [
              {
                id = "Tray";
              }
              {
                id = "plugin:kde-connect";
              }
              {
                id = "KeyboardLayout";
                displayMode = "forceOpen";
              }
              {
                id = "Battery";
                displayMode = "graphic";
              }
              {
                id = "plugin:screen-recorder";
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
                id = "plugin:mini-docker";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "ControlCenter";
              }
            ];
          };

          general = {
            dimmerOpacity = "0";
            showScreenCorners = true;
            lockOnSuspend = true;
            lockScreenAnimations = true;
            enableLockScreenMediaControls = true;
            passwordChars = true;
            enableShadows = false;
            # shadowDirection = "center";
            telemetryEnabled = false;
            clockStyle = "analog";
          };

          ui.settingsPanelMode = "centered";
          ui.boxBorderEnabled = true;

          location.name = "Moscow";
          location.weatherShowEffects = false;

          wallpaper = {
            directory = "${config.home.homeDirectory}/Pictures/Wallpapers";
            useWallhaven = true;
            wallhavenSorting = "toplist";
          };

          controlCenter.shortcuts = {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "KeepAwake";
              }
            ];
          };

          dock.enabled = false;

          network.bluetoothRssiPollingEnabled = true;

          notifications.enableKeyboardLayoutToast = false;

          audio.preferredPlayer = "spotify";

          desktopWidgets = {
            enabled = true;
            gridSnap = true;
            monitorWidgets = [
              {
                name = "eDP-1";
                widgets = [
                  {
                    id = "MediaPlayer";
                    roundedCorners = true;
                    hideMode = "hidden";
                    scale = 1.4;
                    showAlbumArt = true;
                    showBackground = false;
                    showButtons = true;
                    showVisualizer = false;
                    x = 32;
                    y = 1120;
                  }
                  # {
                  #   id = "SystemStat";
                  #   diskPath = "/";
                  #   layout = "side";
                  #   roundedCorners = true;
                  #   scale = 1;
                  #   showBackground = true;
                  #   statType = "CPU";
                  #   x = 1760;
                  #   y = 1120;
                  # }
                ];
              }
            ];
          };
        };
      };
    };
}
