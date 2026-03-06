{ inputs, ... }: {
  flake.homeModules.noctalia-shell = { config, pkgs, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    home.packages = with pkgs; [
      gpu-screen-recorder
      kdePackages.qttools
      kdePackages.krdp
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
          lockOnSuspend = false;
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
