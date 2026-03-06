{ self, lib, ... }: {
  flake.nixosConfigurations.acer = lib.nixosSystem {
    modules = with self.nixosModules; [
      base
      btrfs
      filesystem
      grub
      stylix
      tailscale
    ];
  };
}
