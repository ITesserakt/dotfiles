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
      extra-substituters
      filesystem
      # gnome
      grub
      hyprland
      kde-connect
      nebula
      nh
      nix
      nvidia
      plymouth
      redmi
      regreet
      steam
      stylix
      tailscale
      # zfs
      zswap
    ];
  };

  flake.nixosModules.redmi = { pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
    ];
    
    system.stateVersion = "24.05";

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelModules = [
      "ddcci_backlight"
      "i2c-dev"
    ];
    # boot.supportedFilesystems = [ "zfs" ];
    # boot.zfs.forceImportRoot = false;
  };
}
