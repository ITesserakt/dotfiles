{
  perSystem = { pkgs, ... }: {
    packages.auf = pkgs.rustPlatform.buildRustPackage {
      pname = "auf";
      version = "0.1";

      src = pkgs.fetchFromGitHub {
        owner = "ITesserakt";
        repo = "auf";
        rev = "master";
        sha256 = "sha256-FOcLw8rIbCs16rWl55uVZHSLjX2fgQfBQvwFNAp/0hY=";
      };

      cargoHash = "sha256-hqatOKS1iEuLmdjND15sS9quEjNzHfrYLrOqDNtz8Zc=";
    };
  };
}
