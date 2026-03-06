{
  flake.nixosModules.filesystem = {
    boot.loader.grub = {
      efiSupport = true;
      mirroredBoots = [{
        devices = [ "nodev" ];
        path = "/boot";
      }];
    };

    boot.supportedFilesystems = [ "zfs" "ntfs" ];
  };
}
