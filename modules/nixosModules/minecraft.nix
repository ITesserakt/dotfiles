{
  flake.nixosModules.minecraft = { pkgs, ... }: {
    services.minecraft-server = {
      enable = true;
      eula = true;
      package = pkgs.minecraftServers.vanilla-1-21;
      declarative = false;
      openFirewall = true;
    };
  };
}
