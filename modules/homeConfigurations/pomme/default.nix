{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.pomme =
    { pkgs, ... }:
    {
      users.users.pomme = {
        isNormalUser = true;
        description = "pomme";
        extraGroups = [
          "networkmanager"
          "wheel"
          "input"
          "video"
          "uinput"
        ];
        shell = pkgs.fish;
      };

      programs.fish.enable = true;
    };

  flake.homeConfigurations.pomme = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
      overlays = [
        (self.meta.mkOverlay ({ nightly, ... }: { wf-recorder = nightly.wf-recorder; }))
      ];
    };

    modules = with self.homeModules; [
      base
      bat
      btop
      carapace
      direnv
      eza
      fish
      git
      gnome
      helix
      hyprland
      kitty
      nix-index
      nix-search-tv
      noctalia-shell_v5
      noctalia_wallhaven
      noctalia_wallpaper-depth
      nushell
      oh-my-posh
      ollama
      pomme
      stylix
      sunsetr
      syncthing
      tailscale
      vicinae
      wluma
      yazi
      zed-editor
      zen-browser
      zoxide
    ];
  };

  flake.homeModules.pomme =
    { pkgs, ... }:
    {
      home.username = "pomme";
      home.homeDirectory = "/home/pomme";
      home.stateVersion = "26.05";

      nixpkgs.config.allowUnfree = true;

      home.shell.enableNushellIntegration = true;

      home.packages = with pkgs; [
        telegram-desktop
        zotero
        wf-recorder
        self.packages.${pkgs.stdenv.hostPlatform.system}.balatro
        ollama
      ];
    };
}
