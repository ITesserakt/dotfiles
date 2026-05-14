{
  config,
  ...
}:
{
  flake.overlays = {
    # replace broken packages with stable versions
    direnv = config.flake.meta.mkOverlay (
      { stable, ... }:
      {
        direnv = stable.direnv;
      }
    );

    clapper = config.flake.meta.mkOverlay (
      { stable, ... }:
      {
        clapper = stable.clapper;
      }
    );

    libreoffice = config.flake.meta.mkOverlay (
      { stable, ... }:
      {
        libreoffice-qt6-fresh = stable.libreoffice-qt6-fresh;
      }
    );
  };
}
