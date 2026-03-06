{
  flake.nixosModules.kde-connect = { pkgs, ... }: {
    programs.kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
  };
}
