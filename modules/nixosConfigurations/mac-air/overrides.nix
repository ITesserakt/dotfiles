{
  flake.nixosModules.mac-air = { lib, ... }: {
    services.xserver.xkb.options = lib.mkForce "grp:ctrl_space_toggle";

    services.keyd.keyboards.default.ids = [ "05ac:0351:c0152ca3" ];

    boot.loader.grub.efiSupport = lib.mkForce false;

    services.beesd.filesystems.root.hashTableSizeMB = lib.mkForce 256;
    services.beesd.filesystems.root.extraOptions = lib.mkForce [ "--thread-count" "2" ];

    fileSystems."/".options = [ "compress-force=zstd:2" ];
    fileSystems."/home".options = [ "compress-force=zstd:2" ];
    fileSystems."/nix".options = [ "compress-force=zstd:2" ];
  };
}
