{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    with (pkgs // inputs.erosanix.packages.x86_64-linux // inputs.erosanix.lib.x86_64-linux);
    {
      packages.test-vkr = mkWindowsApp rec {
        wine = wineWow64Packages.stagingFull;

        pname = "test-vkr";
        version = "1.0.0";

        src = builtins.fetchurl {
          url = "http://vkr.bmstu.ru/TestVkr.exe";
          sha256 = "sha256:0aryjr71cih4ix2vk4fk9fw6vass0jkbqbirq55dv6r4f9di9naw";
        };

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
