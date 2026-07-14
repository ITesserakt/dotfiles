{ inputs, self, ... }:
{
  flake.modules.darwin.mac-air =
    { pkgs, ... }:
    {
      users.users.apfel = {
        uid = 502;
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
      overlays = [
        (self.meta.mkOverlay ({ stable, ... }: { kitty = stable.kitty; }))
      ];
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
      nix-search-tv
      nushell
      oh-my-posh
      spotify
      stylix
      syncthing
      vicinae
      yazi
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.apfel =
    { pkgs, lib, ... }:
    {
      home.username = "apfel";
      home.homeDirectory = "/Users/apfel";
      home.stateVersion = "26.05";

      nixpkgs.config.allowUnfree = true;

      home.shell.enableNushellIntegration = true;
      home.shell.enableZshIntegration = true;

      home.packages = with pkgs; [
        obsidian
        zotero
      ];

      home.sessionVariables = {
        SHELL = "${lib.getExe pkgs.nushell} -l -i";
      };

      programs.zsh.enable = true;
    };
}
