{ self, lib, ... }: {
  flake.nixosConfigurations.mac-air = lib.nixosSystem {
    modules = with self.nixosModules; [
      base
      beesd
      btrfs
      hyprland
      mac-air
      nh
      nix
      stylix
      tailscale
    ];
  };

  flake.nixosModules.mac-air = {
    system.stateVersion = "26.05";
  };
}
