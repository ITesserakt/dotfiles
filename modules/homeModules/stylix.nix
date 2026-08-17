{ self, inputs, ... }:
{
  flake.homeModules.stylix =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
      ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${self.meta.global-theme}.yaml";
        polarity = lib.mkDefault "dark";

        fonts = {
          serif.package = pkgs.roboto-serif;
          serif.name = "Roboto Serif";

          sansSerif.package = pkgs.roboto;
          sansSerif.name = "Roboto";

          monospace.package = pkgs.monaspace;
          monospace.name = "Monaspace Krypton Var";
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
