{ config, ... }:
{
  flake.homeModules.hyprlock =
    { lib, ... }:
    {
      programs.hyprlock = {
        enable = true;

        settings.general.disable_loading_bar = false;

        settings.background = lib.mkForce [
          {
            pack = "screenshot";
            blur_passes = 3;
          }
        ];

        settings.label =
          let
            font_family = config.flake.meta.font.monospace;
          in
          [
            {
              text = ''cmd[update:30000] echo "$(date +"%R")"'';
              font_size = 90;
              inherit font_family;
              position = "-30, 0";
              halign = "right";
              walign = "top";
            }
            {
              text = ''cmd[update:43200000] echo "$(date +"%A,%e %B %Y")"'';
              font_size = 25;
              inherit font_family;
              position = "-30, -150";
              halign = "right";
              walign = "top";
            }
          ];
      };
    };
}
