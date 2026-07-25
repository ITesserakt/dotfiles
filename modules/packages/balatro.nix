{
  perSystem = { pkgs, ... }: {
    packages.balatro = pkgs.stdenv.mkDerivation {
      pname = "balatro";
      version = "1.0.1o-FULL";

      src = builtins.fetchurl {
        url = "https://files.catbox.moe/oo7sdm.love";
        name = "balatro.love";
        sha256 = "sha256:1rr2mi74ibx7n662cvwngbrm0wlpayl3qkpwi2psgk7jzf97iff7";
      };

      dontUnpack = true;

      nativeBuildInputs = with pkgs; [
        makeBinaryWrapper
      ];

      installPhase = ''
        runHook preInstallPhase

        mkdir -p $out/bin
        ln -s ${pkgs.lib.getExe pkgs.love} $out/bin/.balatro-launcher
        mkdir -p $out/share
        cp $src $out/share/balatro.love

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
