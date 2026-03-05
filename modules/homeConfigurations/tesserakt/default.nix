{ self, config, inputs, ... }:
{
  flake.homeConfigurations.tesserakt = inputs.home-manager.lib.homeManagerConfiguration {
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
      git
      gnome
      helix
      hypridle
      hyprland
      kde-connect
      kitty
      nix-index
      nix-search-tv
      noctalia-shell
      nushell
      nvs
      oh-my-posh
      spotify
      stylix
      syncthing
      tailscale
      tesserakt
      vicinae
      wlsunset
      yazi
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.tesserakt = { pkgs, ... }: {
    home.username = "tesserakt";
    home.homeDirectory = "/home/tesserakt";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    home.shell = {
      enableNushellIntegration = true;
    };

    home.packages = with pkgs; [
      materialgram
      obsidian
      remmina
      kdePackages.wacomtablet
      graphite
      rnote
      jetbrains.rust-rover
      zotero
      typst
      distrobox
      config.flake.packages.${pkgs.stdenv.hostPlatform.system}.test-vkr
    ];
  };
}
