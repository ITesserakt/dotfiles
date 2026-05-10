{
  perSystem =
    { pkgs, ... }:
    let
      mkWindowsApp = pkgs.callPackage ./_mkWindowsApp {
        inherit (pkgs.lib) makeBinPath;
      };
      pname = "test-vkr";
      src = builtins.fetchurl {
        url = "http://vkr.bmstu.ru/TestVkr.exe";
        sha256 = "sha256:0aryjr71cih4ix2vk4fk9fw6vass0jkbqbirq55dv6r4f9di9naw";
      };
    in
    with pkgs;
    {
      packages.test-vkr = mkWindowsApp {
        wine = wineWow64Packages.stagingFull;

        inherit pname src;
        version = "1.0.0";

        dontUnpack = true;

        wineArch = "win64";
        inputHashMethod = "store-path";

        winAppRun = ''
          	  wine ${src} "$ARGS"
          	'';

        installPhase = ''
            	  runHook preInstall

          		  ln -s $out/bin/.launcher $out/bin/${pname}

            	  runHook postInstall
            	'';
      };
    };
}
