{ self, lib, ... }:
{
  flake.nixosConfigurations.redmi = lib.nixosSystem {
    modules = with self.nixosModules; [
      appimage
      auto-cpufreq
      base
      beesd
      btrfs
      clight
      docker
      filesystem
      gnome
      grub
      hyprland
      kde-connect
      nh
      nix
      nvidia
      plymouth
      redmi
      steam
      stylix
      tailscale
      zfs
      zswap
    ];
  };

  flake.nixosModules.redmi = { pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
    ];
    
    system.stateVersion = "24.05";

    boot.kernelPackages = pkgs.linuxPackages_6_18;
    boot.kernelModules = [
      "ddcci_backlight"
      "i2c-dev"
    ];
  };
}
