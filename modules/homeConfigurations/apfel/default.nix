{ inputs, self, ... }: {
  flake.modules.darwin.mac-air = { pkgs, ... }: {
    users.users.apfel = {
      description = "apfel";
      shell = pkgs.nushell;
    };

    users.knownUsers = [ "apfel" ];
    programs.zsh.enable = true;
  };

  flake.homeConfigurations.apfel = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-darwin";
      allowUnfree = true;
    };

    modules = with self.homeModules; [
      apfel
      base
      bat
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
      syncthing
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
    home.shell.enableZshIntegration = true;

    home.packages = with pkgs; [
      bitwarden-desktop
      obsidian
      telegram-desktop
    ];

    home.sessionVariables = {
      SHELL = "${lib.getExe pkgs.nushell} -l -i";
    };

    programs.zsh.enable = true;
  };
}
