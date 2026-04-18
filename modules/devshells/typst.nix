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

          mkTypstPackageFromGitHub = name: version: config: {
            inherit name version;
            namespace = "local";
            input = pkgs.fetchFromGitHub config;
          };

          unpublishedTypstPackages = mkTypstPackagesDrv "unpublished-typst-packages" [
            (mkTypstPackageFromGitHub "bmstu-report" "0.1.3" {
              owner = "ITesserakt";
              repo = "typst-bmstu-report";
              rev = "master";
              sha256 = "sha256-Y2+1CHr8Yufz6JYren/zqPe4wJTx3Y0xyNchft2MwYE=";
            })
          ];
        in
        {
          packages = with pkgs; [
            tinymist
            typstyle
            just
            just-lsp
          ];

          env = [
            {
              name = "TYPST_PACKAGE_PATH";
              value = lib.strings.escapeShellArg unpublishedTypstPackages;
            }
          ];
        };
    };
}
