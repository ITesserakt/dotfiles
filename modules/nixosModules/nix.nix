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
      substituters = [
        "https://hyprland.cachix.org"
        # "https://cache.nixos-cuda.org"
        # "https://cosmic.cachix.org/"
      ];
      trusted-substituters = [
        "hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
      auto-optimise-store = true;
    };

    nix.optimise.automatic = true;
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";

    nix.nixPath = [ "nixpkgs=${args.config.nixpkgs.flake.source}" ];
    nix.channel.enable = false;
  };
}
