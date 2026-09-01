{
  flake.nixosModules.ollama = {
    services.ollama = {
      enable = true;
      host = "0.0.0.0";
      port = 11434;
      loadModels = [
        "gemma4:e2b"
        "gpt-oss:latest"
      ];
      syncModels = true;
      user = "ollama";
      environmentVariables = {
        OLLAMA_ORIGINS = "http://100.107.186.162:11434,http://ollama.alpaca-zebra.ts.net:11434";
      };
    };
  };
}
