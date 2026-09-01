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
      ddcci
      docker
      extra-substituters
      filesystem
      # gnome
      grub
      hyprland
      kde-connect
      nh
      nix
      noctalia-greeter
      nvidia
      ollama
      plymouth
      redmi
      steam
      stylix
      tailscale
      # zfs
      zswap
    ];
  };

  flake.nixosModules.redmi = {
    imports = [
      ./_hardware-configuration.nix
    ];
    
    system.stateVersion = "24.05";
  };
}
