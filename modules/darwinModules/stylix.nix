{ inputs, config, ... }: {
	flake.modules.darwin.stylix = { pkgs, ... }: {
		imports = [
			inputs.stylix.darwinModules.stylix
		];

		stylix = {
			enable = true;
			base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
			polarity = "either";

			fonts = {
				serif.package = pkgs.roboto-serif;
				serif.name = "Roboto Serif";
	
				sansSerif.package = pkgs.roboto;
				sansSerif.name = "Roboto";

				monospace.package = pkgs.monaspace;
				monospace.name = config.flake.meta.font.monospace;

				emoji.package = pkgs.noto-fonts-color-emoji;
				emoji.name = "Noto Color Emoji";
			};
		};
	};
}
