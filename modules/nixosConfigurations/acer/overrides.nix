{
  flake.nixosModules.acer = { pkgs, ... }: {
    networking.hostId = "e3fb253e";
    networking.hostName = "acer";
    networking.nameservers = [ "1.1.1.1" "8.8.8.8" "192.168.1.1" ];

    services.printing.drivers = with pkgs; [
      hplip
      gutenprint
      gutenprintBin
      foomatic-db
      foomatic-db-engine
      foomatic-db-ppds
    ];

    programs.dconf.profiles.user.databases = [{
      settings."org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
    }];
  };
}
