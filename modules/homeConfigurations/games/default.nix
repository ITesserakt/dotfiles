{ inputs, self, ... }:
{
  flake.nixosModules.redmi = {
    users.users.games = {
      isNormalUser = true;
      description = "games";
      extraGroups = [
        "input"
        "video"
        "networkmanager"
      ];
    };
  };

  flake.homeConfigurations = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
      bat
      base
      btop
      carapace
      direnv
      discord
      eza
      gnome
      helix
      hypridle
      hyprland
      kde-connect
      kitty
      nix-index
      nix-search-tv
      noctalia-shell
      oh-my-posh
      spotify
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
