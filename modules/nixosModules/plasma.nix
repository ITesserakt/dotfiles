{ self, ... }: {
  flake.nixosModules.plasma = { pkgs, ... }: {
    services.desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
      ];
    };

    environment.systemPackages = with pkgs; [
      kdePackages.qtwayland
      self.flake.packages.${pkgs.stdenv.hostPlatform.system}.sddm-astronaut-theme
    ];

    environment.plasma.excludePackages = with pkgs.kdePackages; [
      dolphin
      elisa
      kate
      ark
      konsole
      okular
    ];
  };
}
