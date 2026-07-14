{
  self,
  config,
  inputs,
  ...
}:
{
  flake.nixosModules.redmi =
    { pkgs, ... }:
    {
      users.users.tesserakt = {
        isNormalUser = true;
        description = "tesserakt";
        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
          "video"
          "docker"
          "i2c"
        ];
        shell = pkgs.nushell;
      };
    };

  flake.homeConfigurations.tesserakt = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;

      overlays = with self.overlays; [
        clapper
      ];
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
      # hypridle
      hyprland
      kde-connect
      kitty
      nix-index
      nix-search-tv
      # noctalia-shell
      noctalia-shell_v5
      nushell
      nvs
      oh-my-posh
      # ollama
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

  flake.homeModules.tesserakt =
    { pkgs, ... }:
    {
      home.username = "tesserakt";
      home.homeDirectory = "/home/tesserakt";
      home.stateVersion = "24.05";

      nixpkgs.config.allowUnfree = true;

      home.shell = {
        enableNushellIntegration = true;
      };

      home.packages = with pkgs; [
        telegram-desktop
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
        wayshot
        jetbrains-toolbox
      ];
    };
}
