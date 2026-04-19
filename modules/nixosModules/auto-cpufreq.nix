{
  flake.nixosModules.auto-cpufreq =
    { lib, ... }:
    {
      services.upower.enable = true;
      services.auto-cpufreq = {
        enable = true;
        settings = lib.mkOverride 900 {
          charger.governor = "balance_performance";
          charger.energy_perf_bias = "default";
          charger.energy_performance_preference = "balance_performance";

          battery.turbo = "never";
        };
      };
    };
}
