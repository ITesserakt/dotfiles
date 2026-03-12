{ self, inputs, ... }: {
	flake.darwinConfigurations."MacBook-Air-Vladimir" = inputs.nix-darwin.lib.darwinSystem {
		modules = with self.nixosModules; [
			mac-air
			base
			nh
			nix
			stylix
			tailscale
		];
	};

	flake.nixosModules.mac-air = {
		system.stateVersion = 6;
		nixpkgs.hostPlatform = "aarch64-darwin";
	};
}
