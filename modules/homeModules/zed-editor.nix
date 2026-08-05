{
  flake.homeModules.zed-editor = {
    programs.zed-editor = {
      enable = true;
      userKeymaps = [
        {
          context = "Workspace";
          bindings."shift shift" = "file_finder::Toggle";
        }
        {
          context = "Editor && vim_mode == insert";
          bindings."j k" = "vim::NormalBefore";
        }
        {
          context = "Dock || Workspace || OutlinePanel || ProjectPanel || CollabPanel || Terminal";
          bindings."shift-escape" = "workspace::CloseActiveDock";
        }
        {
          context = "Editor";
          bindings."alt-shift-l" = "editor::Format";
          unbind."shift-f10" = "editor::OpenContextMenu";
        }
      ];
      mutableUserKeymaps = true;
      userSettings = {
        always_treat_brackets_as_autoclosed = true;
        autosave.after_delay.milliseconds = 300;
        base_keymap = "JetBrains";
        code_lens = "on";
        completion_menu_item_kind = "symbol";
        debugger.stepping_granularity = "statement";
        diagnostics.inline.enabled = true;
        disable_ai = true;
        document_folding_ranges = "on";
        edit_predictions.allow_data_collection = "no";
        format_on_save = "on";
        git_panel.group_by = "staging";
        git_panel.tree_view = true;
        helix_mode = true;
        inlay_hints.enabled = true;
        inlay_hints.show_background = true;
        preferred_line_length = 120;
        project_panel.dock = "left";
        relative_line_numbers = "enabled";
        scroll_beyond_last_line = "one_page";
        semantic_tokens = "combined";
        sticky_scroll.enabled = true;
        toolbar.breadcrumbs = true;
      };

      userSettings.lsp = {
        rust-analyzer.initialization_options = {
          assist.expressionFillDefault = "default";
          check.workspace = false;
          completion.addSemicolonToUnit = true;
          completion.callable.snippets = "add_parentheses";
        };
      };

      userSettings.languages = {
        Rust = {
          colorize_brackets = false;
          tasks.enabled = true;
          inlay_hints.show_parameter_hints = false;
          indent_guides.coloring = "fixed";
          indent_guides.background_coloring = "disabled";
        };
        "WGSL/WESL".auto_indent = "preserve_indent";
      };
      mutableUserSettings = true;
    };
  };
}
