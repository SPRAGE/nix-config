{

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    # Optional: load models on startup
    loadModels = [ "gemma3:12b" ];
  };
}
