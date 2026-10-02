{
  perSystem = { pkgs, ... }: {
    packages.nla3d = pkgs.stdenv.mkDerivation {
      pname = "nla3d";
      version = "0.0.0";

      src = pkgs.fetchFromGitHub {
        repo = "nla3d";
        owner = "ITesserakt";
        rev = "3dd7a192ecc5";
        sha256 = "sha256-lvXVBXftuwn/F6/BQjFKkFlKrujZVYVDYutr39DYe5Q=";
        fetchSubmodules = true;
      };

      nativeBuildInputs = with pkgs; [
        cmake
      ];
    };
  };
}
