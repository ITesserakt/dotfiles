{ self, inputs, ... }: {
	flake.darwinConfigurations."MacBook-Air-Vladimir" = inputs.nix-darwin.lib.darwinSystem {
		modules = with self.modules.darwin; [
			base
			mac-air
			nix
			stylix
		];
	};

	flake.modules.darwin.mac-air = {
		system.stateVersion = 6;
		nixpkgs.hostPlatform = "aarch64-darwin";

		programs.zsh.enable = true;

		security.pam.services.sudo_local.touchIdAuth = true;
	};
}
