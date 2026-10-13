{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      devshells.typst =
        let
          mkTypstPackagesDrv =
            name: entries:
            let
              linkFarmEntries = lib.foldl (
                set:
                {
                  name,
                  version,
                  namespace,
                  input,
                }:
                set
                // {
                  "${namespace}/${name}/${version}" = input;
                }
              ) { } entries;
            in
            pkgs.linkFarm name linkFarmEntries;

          typst-bmstu-report = pkgs.fetchFromGitHub {
            owner = "ITesserakt";
            repo = "typst-bmstu-report";
            rev = "master";
            sha256 = "sha256-krmYmznnXqBAU0rNYO57iWbfmJFHSHmVOKvV/EYgWB8=";
          };

          typst-bmstu-presentation = pkgs.fetchFromGitHub {
            owner = "ITesserakt";
            repo = "typst-bmstu-presentation";
            rev = "a6b0c39dc145bf61cb19c707adec94fa2ba1e600";
            sha256 = "sha256-7cXGWU+rPjo0s+w9HebACwx0iieZ/987uoT4le11Qzk=";
          };

          typst-bmstu-thesis = pkgs.fetchFromGitHub {
            owner = "ITesserakt";
            repo = "typst-bmstu-thesis";
            rev = "5d54ba6201dda8cbb3871bf388a60b7b99f2e95c";
            sha256 = "sha256-fXNRL3RLZWym6+mrTqq/LKQ1DcblIn6QgT84NE5zoUM=";
          };

          mkTypstPackage = name: input: {
            inherit name input;
            namespace = "local";
            version = (fromTOML (builtins.readFile "${input}/typst.toml")).package.version;
          };

          unpublishedTypstPackages = mkTypstPackagesDrv "unpublished-typst-packages" [
            (mkTypstPackage "bmstu-report" typst-bmstu-report)
            (mkTypstPackage "bmstu-presentation" typst-bmstu-presentation)
            (mkTypstPackage "bmstu-thesis" typst-bmstu-thesis)
          ];
        in
        {
          packages = with pkgs; [
            tinymist
            typstyle
            just
            just-lsp
            typst
          ];

          env = [
            {
              name = "TYPST_PACKAGE_PATH";
              value = "${lib.strings.escapeShellArg unpublishedTypstPackages}";
            }
            {
              name = "TYPST_FONT_PATHS";
              prefix = builtins.concatStringsSep ":" [
                "${typst-bmstu-report}/fonts"
                "${typst-bmstu-presentation}/fonts"
              ];
            }
            {
              name = "TYPST_IGNORE_SYSTEM_FONTS";
              value = "true";
            }
          ];
        };
    };
}
