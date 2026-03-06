{ self, lib, ... }: {
  flake.nixosConfigurations.acer = lib.nixosSystem {
    modules = with self.nixosModules; [
      acer
      base
      btrfs
      filesystem
      gnome
      grub
      nh
      nix
      ssh
      stylix
      tailscale
    ];
  };

  flake.nixosModules.acer = {
    system.stateVersion = "24.05";
  };
}
