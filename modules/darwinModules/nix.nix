{ self, ... }: {
	flake.modules.darwin.nix = args: {
		documentation.enable = false;
		
		nix.settings = {
			experimental-features = [
				"nix-command"
				"flakes"
			];
			auto-optimise-store = true;
		};

		nix.optimise.automatic = true;
		nix.gc.automatic = true;

		nix.nixPath = [ "nixpkgs=${args.config.nixpkgs.flake.source}" ];
		nix.channel.enable = false;
	};
}
