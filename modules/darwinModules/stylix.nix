{ inputs, self, ... }: {
  flake.modules.darwin.stylix = { pkgs, lib, ... }: {
    imports = [
      inputs.stylix.darwinModules.stylix
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

        emoji.package = pkgs.noto-fonts-color-emoji;
        emoji.name = "Noto Color Emoji";
      };
    };
  };
}
