{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.microVM = lib.nixosSystem {
    system = "aarch64-linux";
    modules = with self.nixosModules; [
      btrfs
      microVM
      nh
      nix
    ];
  };

  flake.nixosModules.microVM = { lib, pkgs, ... }: {
    imports = [
      inputs.microvm.nixosModules.microvm
    ];

    microvm.hypervisor = "qemu";
    microvm.vcpu = 4;
    microvm.mem = 3072;
    microvm.shares = [
      {
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        proto = "9p";
      }
    ];
    microvm.interfaces = [{
      type = "user";
      id = "microvm-1";
      mac = "02:00:00:00:00:01";
    }];
    microvm.qemu.extraArgs = [
      "-drive"
      "if=none,id=root,file=/dev/rdisk0s5,format=raw,cache=none"

      "-device"
      "virtio-blk-pci,drive=root"

      "-drive"
      "if=none,id=boot,file=/dev/rdisk0s4,format=raw,cache=none"

      "-device"
      "virtio-blk-pci,drive=boot"
    ];
    microvm.vmHostPackages = import inputs.nixpkgs {
      system = "aarch64-darwin";
      overlays = [
        (self.meta.mkOverlay ({ nightly, ... }: { vfkit = nightly.vfkit; }))
      ];
    };

    services.btrfs.autoScrub.enable = lib.mkForce false;
    nix.optimise.automatic = lib.mkForce false;
    system.stateVersion = "26.05";

    users.users.root = {
      isSystemUser = true;
      initialPassword = "root";
      packages = with pkgs; [
        btrfs-progs
        (pkgs.writeShellScriptBin "asahi-enter" ''
          mkdir -p /mnt
          mount -o subvol=@ /dev/vda /mnt
          mount -o subvol=@nix /dev/vda /mnt/nix
          mount -o subvol=@home /dev/vda /mnt/home
          mount /dev/vdb /mnt/boot
          nixos-enter
        '')
      ];
    };
    users.defaultUserShell = pkgs.fish;

    programs.fish.enable = true;
  };
}
