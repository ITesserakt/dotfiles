{ self, ... }: {
  flake.homeModules.sunsetr =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      home.packages = [ pkgs.sunsetr ];

      xdg.configFile."sunsetr/sunsetr.toml".source = (pkgs.formats.toml { }).generate "sunsetr-config" {
        backend = "auto";
        transition_mode = "geo";

        smoothing = true;
        startup_duration = 0.5;
        shutdown_duration = 0.5;
        adaptive_interval = 1;

        night_temp = 4000;
        day_temp = 6500;
        night_gamma = 90;
        day_gamma = 100;
        update_interval = "auto";

        latitude = builtins.fromJSON self.meta.latitude;
        longitude = builtins.fromJSON self.meta.longitude;
      };

      wayland.windowManager.hyprland.settings.on =
        lib.optional config.wayland.windowManager.hyprland.enable
          {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline
                # lua
                ''
                  function()
                    hl.exec_cmd("sunsetr")
                  end
                ''
              )
            ];
          };
    };
}
