{
	flake.modules.darwin.base = {
		networking.knownNetworkServices = [
			"Thunderbolt Bridge"
			"Wi-Fi"
			"Tailscale"
		];
	};
}
