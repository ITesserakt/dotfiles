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

  flake.nixosModules.acer = { pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
    ];
    
    system.stateVersion = "24.05";
    boot.kernelPackages = pkgs.linuxPackages_6_18;
  };
}
