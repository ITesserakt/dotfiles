{
  flake.homeModules.mangohud = {
    programs.mangohud = {
      enable = true;
      settings = {
        legacy_layout = false;

        round_corners = 0;

        position = "top-left";
        toggle_hud = "Shift_R+F1";
        hud_compact = true;
        table_columns = 3;
        
        gpu_text = "GPU";
        gpu_stats = true;
        gpu_load_change = true;
        gpu_load_value = [ 50 90 ];
        throttling_status = true;
        gpu_core_clock = true;
        gpu_mem_clock = true;
        gpu_temp = true;
        gpu_power = true;
        
        cpu_text = "CPU";
        cpu_stats = true;
        core_load = true;
        core_bars = true;
        cpu_mhz = true;
        cpu_temp = true;
        cpu_power = true;

        vram = true;

        ram = true;

        fps = true;
        fps_metrics = [ "avg" "0.01" ];

        engine_version = true;

        wine = true;

        frame_timing = true;

        throttling_status_graph = true;
        fps_limit_method = "late";
        toggle_fps_limit = "Shift_L+F1";
        show_fps_limit = true;
        fps_limit = [ "60" "0" ];

        winesync = true;
      };
    };
  };
}
