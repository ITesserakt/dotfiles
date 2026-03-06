{ inputs, config, ... }:
{
  flake.nixosModules.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        polarity = "dark";

        fonts = {
          serif = {
            package = pkgs.roboto-serif;
            name = "Roboto Serif";
          };

          sansSerif = {
            package = pkgs.roboto;
            name = "Roboto";
          };

          monospace = {
            package = pkgs.monaspace;
            name = config.flake.meta.font.monospace;
          };

          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
        };
      };
    };
}
