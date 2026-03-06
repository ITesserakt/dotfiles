{
  flake.homeModules.mangohud = {
    programs.mangohud = {
      enable = true;
      settings = {
        legacy_layout = false;

        round_corners = 0;
        background_color = "000000";

        font_size = 24;
        text_color = "FFFFFF";
        position = "top-left";
        toggle_hud = "Shift_R+F1";
        hud_compact = true;
        table_columns = 3;
        
        gpu_text = "GPU";
        gpu_stats = true;
        gpu_load_change = true;
        gpu_load_value = [ 50 90 ];
        gpu_load_color = [ "FFFFFF" "FFAA7F" "CC0000" ];
        throttling_status = true;
        gpu_core_clock = true;
        gpu_mem_clock = true;
        gpu_temp = true;
        gpu_power = true;
        gpu_color = "2E9762";
        
        cpu_text = "CPU";
        cpu_stats = true;
        core_load = true;
        core_bars = true;
        cpu_mhz = true;
        cpu_temp = true;
        cpu_power = true;
        cpu_color = "2E97CB";

        vram = true;
        vram_color = "AD64C1";

        ram = true;
        ram_color = "C26693";

        fps = true;
        fps_metrics = [ "avg" "0.01" ];

        engine_version = true;
        engine_color = "EB5B5B";

        wine = true;
        wine_color = "EB5B5B";

        frame_timing = true;
        frametime_color = "FFFFFF";

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
