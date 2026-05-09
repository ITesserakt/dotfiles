{ inputs, ... }:
{
  flake.nixosModules.asahi =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.nixos-apple-silicon.nixosModules.default
      ];

      hardware.asahi.setupAsahiSound = true;
      hardware.graphics.enable32Bit = lib.mkForce false;

      networking = {
        networkmanager.wifi.backend = "iwd";
        wireless.iwd = {
          enable = true;
          settings.General.EnableNetworkConfiguration = true;
        };
      };

      environment.systemPackages = with pkgs; [
        asahi-wifisync
        asahi-bless
        asahi-btsync
      ];

      nix.settings.substituters = [
        "https://nixos-apple-silicon.cachix.org"
      ];
      nix.settings.trusted-substituters = [
        "https://nixos-apple-silicon.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };
}
