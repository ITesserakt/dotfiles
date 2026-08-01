{ inputs, ... }: {
  flake.homeModules.hyprshot = { pkgs, config, ... }: {
    home.packages = [
      (pkgs.hyprshot.override {
        hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      })
    ];

    home.sessionVariables = {
      HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
    };
  };
}
