{ self, config, inputs, ... }: {
  flake.nixosModules.albuquerque = { pkgs, ... }: {
    users.users.mars = {
      isNormalUser = true;
      description = "mars";
      extraGroups = [
        "wheel"
        "input"
      ];
      shell = pkgs.nushell;
    };
  };

  flake.homeConfigurations.mars = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    modules = with self.homeModules; [
      bat
      base
      btop
      carapace
      direnv
      eza
      git
      helix
      mars
      nix-index
      nix-search-tv
      nushell
      oh-my-posh
      stylix
      tailscale
      yazi
      zoxide
    ];
  };

  flake.homeModules.mars = { pkgs, ... }: {
    home.username = "mars";
    home.homeDirectory = "/home/mars";
    home.stateVersion = "26.11";

    home.shell.enableNushellIntegration = true;

    home.packages = [
      config.flake.packages.${pkgs.stdenv.hostPlatform.system}.auf
    ];
  };
}
