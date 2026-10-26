{
  flake.nixosModules.builders = {
    nix = {
      distributedBuilds = true;
      buildMachines = [
        {
          hostName = "100.97.251.70";
          sshUser = "nixremote";
          systems = [
            "x86_64-linux"
            "aarch64-linux"
          ];
          protocol = "ssh-ng";
          maxJobs = 10;
          speedFactor = 2;
          supportedFeatures = [
            "nixos-test"
            "benchmark"
            "kvm"
            "big-parallel"
          ];
        }
      ];

      settings = {
        extra-substituters = [
          "ssh-ng://100.97.251.70"
        ];

        fallback = true;

        trusted-public-keys = [

        ];
      };
    };
  };
}
