{ inputs, config, ... }:
{
  flake.homeModules.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
      ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        polarity = "dark";

        fonts = {
          serif.package = pkgs.roboto-serif;
          serif.name = "Roboto Serif";

          sansSerif.package = pkgs.roboto;
          sansSerif.name = "Roboto";

          monospace.package = pkgs.monaspace;
          monospace.name = config.flake.meta.font.monospace;
        };

        opacity.terminal = 0.75;
        opacity.popups = 0.85;

        cursor = {
          package = pkgs.bibata-cursors;
          size = 24;
          name = "Bibata-Modern-Classic";
        };

        icons = {
          enable = true;
          package = pkgs.nordzy-icon-theme;
          dark = "Nordzy-dark";
          light = "Nordzy";
        };
      };
    };
}
