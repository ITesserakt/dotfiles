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

  flake.modules.darwin.mac-air = { pkgs, ... }: {
    system.stateVersion = 6;
    nixpkgs.hostPlatform = "aarch64-darwin";

    programs.zsh.enable = true;

    security.pam.services.sudo_local.touchIdAuth = true;

    nix.linux-builder.enable = true;
    nix.linux-builder.config.virtualisation.cores = 4;

    stylix.polarity = "either";

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

    system.primaryUser = "apfel";
  };
}
