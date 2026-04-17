{
  self,
  inputs, ...
}: {
  flake.nixosModules.pomme = { pkgs, ... }: {
    users.users.pomme = {
      isNormalUser = true;
      description = "pomme";
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "video"
      ];
      shell = pkgs.nushell;
    };
  };

  flake.homeConfigurations.pomme = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-linux";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
      bat
      base
      btop
      carapace
      direnv
      eza
      git
      gnome
      helix
      hypridle
      hyprland
      kitty
      nix-index
      nix-search-tv
      noctalia-shell
      nushell
      oh-my-posh
      stylix
      syncthing
      tailscale
      pomme
      vicinae
      yazi
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.pomme = { pkgs, ... }: {
    home.username = "pomme";
    home.homeDirectory = "/home/pomme";
    home.stateVersion = "26.05";

    nixpkgs.config.allowUnfree = true;

    home.shell.enableNushellIntegration = true;

    home.packages = with pkgs; [
      materialgram
      libreoffice-qt-fresh-unwrapped
    ];
  };
}
