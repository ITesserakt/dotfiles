{
  flake.homeModules.ollama = { lib, ... }: {
    services.ollama = {
      enable = true;
      acceleration = lib.mkDefault "cuda";
      host = "0.0.0.0";
    };
  }; 
}
