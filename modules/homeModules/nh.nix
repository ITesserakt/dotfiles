{
  flake.homeModules.nh = {
    programs.nh = {
      enable = true;
      flake = "github:ITesserakt/dotfiles";
    };
  };
}
