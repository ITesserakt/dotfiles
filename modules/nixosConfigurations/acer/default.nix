{ self, lib, ... }: {
  flake.nixosConfigurations.acer = lib.nixosSystem {
    modules = with self.nixosModules; [
      acer
      base
      btrfs
      filesystem
      gnome
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

    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    boot.loader.grub.enable = pkgs.lib.mkForce false;
    
    system.stateVersion = "24.05";
    boot.kernelPackages = pkgs.linuxPackages_6_18;
  };
}
