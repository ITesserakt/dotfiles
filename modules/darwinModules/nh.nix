{ self, ... }: {
	flake.modules.darwin.nh = {
		programs.nh = {
			enable = true;
			flake = "github:ITesserakt/dotfiles";
		};
	};
}
