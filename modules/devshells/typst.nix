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
            sha256 = "sha256-Y2+1CHr8Yufz6JYren/zqPe4wJTx3Y0xyNchft2MwYE=";
          };

          typst-bmstu-presentation = pkgs.fetchFromGitHub {
            owner = "ITesserakt";
            repo = "typst-bmstu-presentation";
            rev = "master";
            sha256 = "sha256-P7f0lQjwvs/7H0ATlAd54vnXnuhjMihl/jxst2Dx6sQ=";
          };

          unpublishedTypstPackages = mkTypstPackagesDrv "unpublished-typst-packages" [
            {
              name = "bmstu-report";
              version = "0.1.3";
              namespace = "local";
              input = typst-bmstu-report;
            }
            {
              name = "bmstu-presentation";
              version = "0.1.1";
              namespace = "local";
              input = typst-bmstu-presentation;
            }
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
