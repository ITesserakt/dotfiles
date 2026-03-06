{ self, inputs, ... }:
{
  flake.nixosModules.acer =
    { pkgs, ... }:
    {
      users.users.local = {
        isNormalUser = true;
        description = "local";
        extraGroups = [
          "video"
          "input"
          "scanner"
          "lp"
        ];
        shell = pkgs.fish;
      };
      programs.fish.enable = true;
    };

  flake.homeConfigurations.local = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
      base
      bat
      carapace
      eza
      firefox
      gnome
      micro
    ];
  };

  flake.homeModules.local =
    { pkgs, ... }:
    {
      home.username = "local";
      home.homeDirectory = "/home/local";
      home.stateVersion = "23.11";

      nixpkgs.config.allowUnfree = true;

      home.shell = {
        enableFishIntegration = true;
      };

      home.packages = with pkgs; [
        vivaldi
        telegram-desktop
        simple-scan
      ];
    };
}
