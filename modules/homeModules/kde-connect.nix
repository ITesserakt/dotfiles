{
  flake.homeModules.kde-connect = { pkgs, ... }: {
    services.kdeconnect = {
      enable = true;
      indicator = false;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
  };
}
