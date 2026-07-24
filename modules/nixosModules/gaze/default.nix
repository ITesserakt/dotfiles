{ inputs, ... }: {
  flake.nixosModules.gaze = { pkgs, ... }: {
    imports = [
      inputs.gaze.nixosModules.default
    ];

    services.gaze = {
      enable = true;
      package = inputs.gaze.packages.${pkgs.stdenv.hostPlatform.system}.gaze.overrideAttrs (p: {
        nativeBuildInputs = p.nativeBuildInputs ++ [ pkgs.llvmPackages.clang ];
        patches = p.patches ++ [ ./nix_pam_location_in_gaze.patch ];
        postFixup =
          let
            # Runtime GStreamer plugins (v4l2src, pipewiresrc).
            gstPluginPath = pkgs.lib.makeSearchPath "lib/gstreamer-1.0" [
              pkgs.gst_all_1.gstreamer
              pkgs.gst_all_1.gst-plugins-base
              pkgs.gst_all_1.gst-plugins-good
              pkgs.pipewire
            ];
          in
          ''
            wrapProgram $out/bin/gazed \
              --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "${gstPluginPath}"
            wrapProgram $out/bin/gaze \
              --set GAZE_NIX_PACKAGE_PATH $out \
              --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "${gstPluginPath}"
          '';
      });
      gui.enable = true;
      gui.package = inputs.gaze.packages.${pkgs.stdenv.hostPlatform.system}.gaze-gui.overrideAttrs (p: {
        nativeBuildInputs = p.nativeBuildInputs ++ [ pkgs.llvmPackages.clang ];
      });
      pam.services.sudo = { };
      pam.services.polkit-1 = { };
    };
  };
}
