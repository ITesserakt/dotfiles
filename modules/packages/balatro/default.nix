{
  perSystem = { pkgs, ... }: {
    packages.balatro = pkgs.stdenv.mkDerivation {
      pname = "balatro";
      version = "1.0.1o-FULL";

      src = ./.;

      nativeBuildInputs = with pkgs; [
        makeBinaryWrapper
      ];

      installPhase = ''
        runHook preInstallPhase

        mkdir -p $out/bin
        ln -s ${pkgs.lib.getExe pkgs.love} $out/bin/.balatro-launcher
        mkdir -p $out/share
        cp $src/balatro.love $out/share/balatro.love

        runHook postInstallPhase
      '';

      postFixup = ''
        makeBinaryWrapper "$out/bin/.balatro-launcher" "$out/bin/balatro" \
          --add-flags $out/share/balatro.love
      '';

      meta.mainProgram = "balatro";
    };
  };
}
