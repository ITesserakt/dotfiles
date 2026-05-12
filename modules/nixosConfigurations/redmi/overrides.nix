{
  flake.nixosModules.redmi =
    { pkgs, lib, ... }:
    {
      networking.hostId = "14ea3ee7";
      networking.hostName = "redmi";

      hardware.nvidia.prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };

      services.desktopManager.gnome.enable = lib.mkForce false;
      services.displayManager.gdm.settings = {
        greeter.Include = "tesserakt,games";
      };

      services.openssh.enable = true;
      # services.sunshine = {
      #   enable = false;
      #   openFirewall = true;
      #   capSysAdmin = true;
      # };
      services.open-webui = {
        enable = false;
        openFirewall = false;
      };

      hardware.graphics.extraPackages = with pkgs; [
        libvdpau-va-gl
        libvpx
      ];
    };
}
