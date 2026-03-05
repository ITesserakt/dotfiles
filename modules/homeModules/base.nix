{
  flake.homeModules.base = { pkgs, lib, ... }: {    
    home.packages = with pkgs; [
      libreoffice-qt6-fresh-unwrapped
      nixpkgs-fmt
      comma
      nixd
      nil
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
      OZONE_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = 1;
    };

    xdg = {
      enable = lib.mkDefault true;
      userDirs.enable = true;
      terminal-exec.enable = true;
    };

    services.home-manager.autoExpire.enable = true;
  };
}
