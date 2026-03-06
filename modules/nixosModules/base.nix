{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      boot = {
        loader.efi.canTouchEfiVariables = true;
        kernelPackages = pkgs.linuxPackages_6_18;
      };

      networking = {
        networkmanager.enable = true;
        nftables.enable = true;
        firewall.enable = true;
        nat.enable = true;
      };

      time = {
        timeZone = "Europe/Moscow";
        hardwareClockInLocalTime = false;
      };

      location.provider = "geoclue2";

      i18n.defaultLocale = "ru_RU.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "ru_RU.UTF-8";
        LC_IDENTIFICATION = "ru_RU.UTF-8";
        LC_MEASUREMENT = "ru_RU.UTF-8";
        LC_MONETARY = "ru_RU.UTF-8";
        LC_NAME = "ru_RU.UTF-8";
        LC_NUMERIC = "ru_RU.UTF-8";
        LC_PAPER = "ru_RU.UTF-8";
        LC_TELEPHONE = "ru_RU.UTF-8";
        LC_TIME = "ru_RU.UTF-8";
      };

      fonts.packages = with pkgs; [
        nerd-fonts.monaspace
        cm_unicode
      ];

      hardware = {
        enableRedistributableFirmware = true;
        graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            libvdpau-va-gl
            libvpx
          ];
        };
        bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
        brillo.enable = true;
        sane.enable = true;
      };

      powerManagement.enable = true;

      services = {
        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];

          xkb.layout = "us,ru";
          xkb.variant = "";
          xkb.options = "grp:win_space_toggle";

          desktopManager.xterm.enable = false;
        };
        libinput.enable = true;

        printing.enable = true;
        saned.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          jack.enable = true;
          wireplumber.enable = true;
        };

        gvfs.enable = true;
        upower.enable = true;
      };

      environment.systemPackages = with pkgs; [
        home-manager
        git
        fd
        vim
      ];
      environment.sessionVariables = {
        COSMIC_DATA_CONTROL_ENABLED = 1;
        _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
      };

      security.rtkit.enable = true;
      security.sudo.enable = true;

      programs = {
        nix-ld.enable = true;
      };

      xdg.portal.enable = true;
    };
}
