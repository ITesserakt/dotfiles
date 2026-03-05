{
  flake.homeModules.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.gnome-browser-connector
      ];
    };
  };
}
