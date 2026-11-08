{
  flake.homeModules.ghostty = { pkgs, ... }: {
    programs.ghostty.enable = true;
    programs.ghostty.package = pkgs.ghostty-bin;

    programs.ghostty.settings = {
      font-family = "Monaspace Krypton Var";
      font-size = 13;
    };
  };
}
