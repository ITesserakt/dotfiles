{
  flake.homeModules.base =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        nixpkgs-fmt
        comma
        nixd
        nil
      ] ++ lib.optionals (!pkgs.stdenv.isDarwin) [
        libreoffice-qt6-fresh
      ];

      home.sessionVariables = {
        NU_EXPERIMENTAL_OPTIONS = "native-clip";
      } // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
        NIXOS_OZONE_WL = 1;
        OZONE_PLATFORM = "wayland";
        MOZ_ENABLE_WAYLAND = 1;
      };

      xdg = {
        enable = lib.mkDefault true;
        userDirs.enable = true;
        terminal-exec.enable = true;
      };

      services.ssh-agent.enable = true;

      services.home-manager.autoExpire.enable = true;
      programs.home-manager.enable = true;
    };
}
