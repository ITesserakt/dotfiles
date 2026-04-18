{ inputs, ... }:
{
  perSystem =
    {
      system,
      pkgs,
      lib,
      ...
    }:
    let
      pluto-command = {
        name = "pluto";
        command = ''
          #!/usr/bin/env julia
          using Pluto
          Pluto.run()
        '';
      };
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "cuda_cccl"
            "cuda_cudart"
            "cuda_cuobjdump"
            "cuda_cupti"
            "cuda_cuxxfilt"
            "cuda_gdb"
            "cuda_nvcc"
            "cuda_nvdisasm"
            "cuda_nvml_dev"
            "cuda_nvprune"
            "cuda_nvrtc"
            "cuda_nvtx"
            "cuda_profiler_api"
            "cuda_sanitizer_api"
            "libcublas"
            "libcufft"
            "libcurand"
            "libcusolver"
            "libcusparse"
            "libnpp"
            "libnvjitlink"
          ];
      };

      devshells.julia = {
        packages = with pkgs; [
          julia-bin
        ];

        commands = [ pluto-command ];
      };

      devshells.julia-cuda = {
        packages = with pkgs; [
          julia-bin
        ];

        env = [
          {
            name = "LD_LIBRARY_PATH";
            value = "/run/opengl-driver/lib:${lib.makeLibraryPath [ pkgs.cudaPackages.cudatoolkit ]}";
          }
        ];

        commands = [ pluto-command ];
      };
    };
}
