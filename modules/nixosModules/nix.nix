{
  flake.nixosModules.nix = args: {
    documentation.nixos.enable = false;
    system.autoUpgrade.enable = false;

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;
    };

    nix.optimise.automatic = true;
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";

    nix.nixPath = [ "nixpkgs=${args.config.nixpkgs.flake.source}" ];
    nix.channel.enable = false;
  };
}
