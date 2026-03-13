{ inputs, self, ... }: {
  flake.modules.darwin."MacBook-Air-Vladimir" = { pkgs, ... }: {
    users.users.apfel = {
      isNormalUser = true;
      description = "apfel";
      shell = pkgs.nushell;
    };
  };

  flake.homeConfigurations.apfel = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-darwin";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
      apfel
      bat
      base
      carapace
      direnv
      eza
      git
      helix
      kitty
      nh
      nix-index
      nushell
      oh-my-posh
      spotify
      stylix
      yazi
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.apfel = { pkgs, lib, ... }: {
    home.username = "apfel";
    home.homeDirectory = "/Users/apfel";
    home.stateVersion = "26.05";

    nixpkgs.config.allowUnfree = true;

    home.shell.enableNushellIntegration = true;

    home.packages = with pkgs; [
      telegram-desktop
      obsidian
    ];

    home.sessionVariables = {
      SHELL = "${lib.getExe pkgs.nushell} -l -i";
    };
  };
}
