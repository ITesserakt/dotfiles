{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.nu_plugin_termplot = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "nu_plugin_termplot";
        version = "0.1.21";

        src = pkgs.fetchFromGitHub {
          owner = "identellica";
          repo = "termplot";
          rev = "v0.1.21";
          sha256 = "sha256-UhHwoz+OoJWmG6ytZ4CmAKJ58KCi7sqf/QkiWXLSkbM=";
        };

        nativeBuildInputs = with pkgs; [
          nodejs
          pnpm
          pnpmConfigHook
          makeWrapper
        ];

        buildInputs = with pkgs; [
          nodejs
        ];

        pnpmDeps = pkgs.fetchPnpmDeps {
          inherit (finalAttrs) pname version src;
          fetcherVersion = 3;
          hash = "sha256-moQPJ77NKDg87BrR6TPnkEOv5PGyZHVVVtbKUZzrTX0=";
        };

        buildPhase = ''
          pnpm build
        '';

        installPhase = ''
          mkdir -p $out
          cp -rT ./ $out/

          wrapProgram "$out/bin/nu_plugin_termplot" \
            --set NUSHELL_VERSION ${pkgs.nushell.version} \
            --set PUPPETEER_EXECUTABLE_PATH ${pkgs.chromium.outPath}/bin/chromium
        '';

        meta.mainProgram = "nu_plugin_termplot";
      });
    };
}
