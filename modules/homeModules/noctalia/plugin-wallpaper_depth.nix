{ self, ... }: {
  flake.homeModules.noctalia_wallpaper-depth =
    { pkgs, ... }:
    self.meta.mkNoctaliaPlugin {
      name = "wallpaper_depth";
      extraDataFiles =
        let
          modelRevision = "4472b7362082ad9968fee890ca0f1e5aca36b93d";
          modelSha256 = "afb6a5c28f3b6bf1618c6e43f02073ef9dfdc70e937502d51603e57b0a1df10c";
          model = pkgs.fetchurl {
            name = "depth-anything-v2-small";
            url = "https://huggingface.co/onnx-community/depth-anything-v2-small/resolve/${modelRevision}/onnx/model.onnx?download=true";
            sha256 = modelSha256;
          };
          modelSizeDrv = pkgs.runCommand "depth-anything-v2-small_size" { } ''
            ${pkgs.busybox}/bin/stat -c %s ${model} > $out
          '';
          modelSize = builtins.fromJSON (builtins.readFile modelSizeDrv);
          python = pkgs.python314.withPackages (
            p: with p; [
              numpy
              onnxruntime
              pillow
            ]
          );
          toJson = (pkgs.formats.json { }).generate;
        in
        {
          "models/depth-anything-v2-small/model.onnx".source = model;
          "runtime/.venv".source = python;
          "setup-operation.json".source = toJson "setup-operation.json" {
            inherit modelRevision modelSize;
            finishedAt = self.lastModified;
            state = "ready";
          };
          "setup.json".source = toJson "setup.json" {
            inherit modelRevision modelSize modelSha256;
            ready = true;
          };
        };
    };
}
