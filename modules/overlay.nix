{
  config,
  ...
}:
{
  flake.overlays = {
    # replace broken packages with stable versions
    direnv = config.flake.meta.mkOverlay (
      { stable, ... }:
      {
        direnv = stable.direnv;
      }
    );

    clapper = config.flake.meta.mkOverlay (
      { stable, ... }:
      {
        clapper = stable.clapper;
      }
    );

    libreoffice = config.flake.meta.mkOverlay (
      { stable, ... }:
      {
        libreoffice-qt6-fresh = stable.libreoffice-qt6-fresh;
      }
    );

    widevine = (
      final: prev:
      let
        inherit (prev) lib stdenv;
      in
      lib.optionalAttrs (stdenv.isLinux && stdenv.isAarch64) {
        wrapFirefox =
          browser: opts:
          let
            extraPrefs = opts.extraPrefs or "" + ''
              lockPref("media.gmp-widevinecdm.version", "system-installed");
              lockPref("media.gmp-widevinecdm.visible", true);
              lockPref("media.gmp-widevinecdm.enabled", true);
              lockPref("media.gmp-widevinecdm.autoupdate", false);
              lockPref("media.eme.enabled", true);
              lockPref("media.eme.encrypted-media-encryption-scheme.enabled", true);
            '';
            widevineCdmDir = "${final.widevine-cdm}/share/google/chrome/WidevineCdm";
            widevineOutDir = "$out/gmp-widevinecdm/system-installed";
          in
          (prev.wrapFirefox browser (opts // { inherit extraPrefs; })).overrideAttrs (previousAttrs: {
            buildCommand = previousAttrs.buildCommand + ''
              mkdir -p "${widevineOutDir}"
              ln -s "${widevineCdmDir}/_platform_specific/linux_arm64/libwidevinecdm.so" "${widevineOutDir}/libwidevinecdm.so"
              ln -s "${widevineCdmDir}/manifest.json" "${widevineOutDir}/manifest.json"
              wrapProgram "$oldExe" --set MOZ_GMP_PATH "${widevineOutDir}"
            '';
          });
      }
    );
  };
}
