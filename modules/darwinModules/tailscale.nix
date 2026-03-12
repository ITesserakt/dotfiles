{ self, ... }: {
	flake.modules.darwin.tailscale = {
		services.tailscale = {
			enable = true;
			useRoutingFeatures = "client";
			openFirewall = true;
		};
	}; 
}
