{ self, inputs, ... }:
{
  flake.darwinConfigurations."MacBook-Air-Vladimir" = inputs.nix-darwin.lib.darwinSystem {
    modules = with self.modules.darwin; [
      base
      mac-air
      mac-app-util
      nix
      stylix
      yabai
    ];
  };

  flake.darwinConfigurations."microvm" = inputs.nix-darwin.lib.darwinSystem {
    modules = with self.modules.darwin; [
      base
      mac-app-util
      nix
      stylix
      yabai
    ];
  };

  flake.modules.darwin.microvm = { pkgs, ... }: {
    nix.linux-builder.enable = true;
    nix.linux-builder.config.virtualisation.cores = 4;

    environment.systemPackages =
      let
        runner = self.nixosConfigurations.microVM.config.microvm.declaredRunner;
        microvm-run = pkgs.writeShellScriptBin "microvm-run" ''
          cleanup() { stty "$(stty -g)"; }
          trap cleanup EXIT
          stty intr ^] susp ^] quit ^]
          exec ${runner}/bin/microvm-run
        '';
      in
      [
        microvm-run
        inputs.microvm.packages.${pkgs.stdenv.hostPlatform.system}.microvm
      ];

    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 6;
    system.primaryUser = "microvm";
  };

  flake.modules.darwin.mac-air = {
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";

    programs.zsh.enable = true;

    security.pam.services.sudo_local.touchIdAuth = true;

    stylix.polarity = "either";

    system.primaryUser = "apfel";
  };
}
