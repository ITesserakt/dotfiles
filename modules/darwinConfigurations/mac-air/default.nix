{ self, inputs, ... }: {
	flake.darwinConfigurations."MacBook-Air-Vladimir" = inputs.nix-darwin.lib.darwinSystem {
		modules = with self.modules.darwin; [
			mac-air
			base
			nix
			stylix
			tailscale
		];
	};

	flake.modules.darwin.mac-air = {
		system.stateVersion = 6;
		nixpkgs.hostPlatform = "aarch64-darwin";
	};
}
