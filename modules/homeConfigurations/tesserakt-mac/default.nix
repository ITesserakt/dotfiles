{ inputs, self, ... }: {
  flake.modules.darwin."MacBook-Air-Vladimir" = { pkgs, ... }: {
    users.users.tesserakt = {
      isNormalUser = true;
      description = "tesserakt";
      shell = pkgs.nushell;
    };
  };

  flake.homeConfigurations.tesserakt-mac = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-darwin";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
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
      tesserakt-mac
      yazi
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.tesserakt-mac = { pkgs, lib, ... }: {
    home.username = "tesserakt";
    home.homeDirectory = "/Users/tesserakt";
    home.stateVersion = "26.05";

    nixpkgs.config.allowUnfree = true;

    home.shell.enableNushellIntegration = true;

    home.packages = with pkgs; [
      telegram-desktop
      obsidian
    ];

    home.sessionVariables = {
      SHELL = "${lib.getExe pkgs.nushell} -l -i";
      EDITOR = lib.getExe pkgs.helix;
    };
  };
}
