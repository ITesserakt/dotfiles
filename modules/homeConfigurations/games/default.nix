{ inputs, self, ... }:
{
  flake.nixosModules.redmi = { pkgs, ... }: {
    users.users.games = {
      isNormalUser = true;
      description = "games";
      extraGroups = [
        "input"
        "video"
        "networkmanager"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true;
  };

  flake.homeConfigurations.games = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
      base
      bat
      btop
      carapace
      direnv
      discord
      eza
      games
      gnome
      helix
      hypridle
      hyprland
      kde-connect
      kitty
      mangohud
      nix-index
      nix-search-tv
      noctalia-shell
      spotify
      starship
      stylix
      tailscale
      vicinae
      yazi
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.games = { pkgs, ... }: {
    home.username = "games";
    home.homeDirectory = "/home/games";
    home.stateVersion = "24.05";

    nixpkgs.config.allowUnfree = true;

    home.shell = {
      enableFishIntegration = true;
    };

    home.packages = with pkgs; [
      cantarell-fonts
      font-awesome
      
      mission-center
      materialgram
      
      mangohud
      heroic
      wineWow64Packages.stagingFull
      
      qbittorrent
      comma

      vintagestory
    ];
  };
}
