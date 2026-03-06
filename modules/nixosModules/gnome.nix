{
  flake.nixosModules.gnome = { pkgs, ... }: {
    services.desktopManager.gnome.enable = true;

    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      baobab
      epiphany
      eog
      geary
      gnome-disk-utility
      gnome-font-viewer
      gnome-logs
      gnome-music
      gnome-connections
      gnome-photos
      gnome-text-editor
      gnome-tour
      gnome-system-monitor
      seahorse
      totem
      yelp
    ];
  };
}
