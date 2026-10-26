{ self, lib, inputs, ... }: {
  flake.nixosConfigurations.albuquerque = lib.nixosSystem {
    modules = with self.nixosModules; [
      albuquerque
      base
      filesystem
      nh
      nix
      stylix
      tailscale
    ];
  };

  flake.nixosModules.albuquerque = { pkgs, ... }: {
    imports = [
      inputs.nixos-wsl.nixosModules.default
      ./_hardware-configuration.nix
    ];

    system.stateVersion = "26.05";
    wsl = {
      enable = true;
      defaultUser = "mars";
      docker-desktop.enable = false;
      wslConf.automount.enabled = true;
    };
    networking.hostName = "albuquerque";
  };
}
