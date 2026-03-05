{
  flake.homeModules.starship.programs.starship.enable = true;

  flake.homeModules.oh-my-posh.programs.oh-my-posh = {
    enable = true;
    useTheme = "kushal";
  };

  flake.homeModules.carapace.programs.carapace.enable = true;

  flake.homeModules.zoxide.programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };

  flake.homeModules.eza.programs.eza = {
    enable = true;
    icons = "auto";
  };

  flake.homeModules.bat.programs.bat.enable = true;
}
