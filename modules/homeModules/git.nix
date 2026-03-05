{
  flake.homeModules.git = {
    programs.git = {
      enable = true;
    };

    programs.lazygit.enable = true;
  };
}
