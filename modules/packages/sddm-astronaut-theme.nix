{
  perSystem =
    { pkgs, ... }:
    {
      packages.sddm-astronaut-theme = pkgs.stdenvNoCC.mkDerivation {
        pname = "sddm-astronaut-theme";
        version = "1.2";

        src = pkgs.fetchFromGitHub {
          owner = "Keyitdev";
          repo = "sddm-astronaut-theme";
          rev = "master";
          sha256 = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
        };

        dontWrapQtApps = true;
        propagatedBuildInputs = with pkgs.kdePackages; [
          qtsvg
        ];

        installPhase =
          let
            basePath = "$out/share/sddm/themes/sddm-astronaut-theme";
          in
          ''
            		mkdir -p ${basePath}
            		cp -r $src/* ${basePath}
            	'';
      };
    };
}
