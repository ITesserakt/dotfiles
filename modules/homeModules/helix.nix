{
  flake.homeModules.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        enable = true;
        settings.editor = {
          scroll-lines = 2;
          line-number = "relative";
          completion-timeout = 50;
          preview-completion-insert = false;
          completion-trigger-len = 1;
          rulers = [ 120 ];
          color-modes = true;
          text-width = 120;
          end-of-line-diagnostics = "info";
          inline-diagnostics.cursor-line = "warning";
          soft-wrap = {
            enable = true;
            wrap-at-text-width = true;
          };
          indent-guides = {
            render = true;
            character = "┆";
          };
          auto-save.after-delay = {
            enable = true;
            timeout = 1000;
          };
          file-picker = {
            hidden = false;
            git-ignore = true;
          };
          lsp = {
            display-inlay-hints = true;
            display-signature-help-docs = false;
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
        settings.keys.normal."A-g" = [
          ":write-all"
          ":new"
          ":insert-output ${pkgs.lazygit}/bin/lazygit"
          ":buffer-close!"
          ":redraw"
        ];
        settings.keys.insert = {
          "C-ц" = [ "delete_word_backward" ];
          "C-backspace" = [ "delete_word_backward" ];
          "C-w" = [ "delete_word_backward" ];
          "A-backspace" = [ ];

          "C-ы" = [ "commit_undo_checkpoint" ];
          "C-ч" = [ "completion" ];
          "C-к" = [ "insert_register" ];
        };
        settings.keys.normal = {

          "й" = [ "replay_macro" ];
          "Й" = [ "record_macro" ];

          "ц" = [ "move_next_word_start" ];
          "Ц" = [ "move_next_long_word_start" ];

          "у" = [ "move_next_word_end" ];
          "У" = [ "move_next_long_word_end" ];
          "A-у" = [ "move_parent_node_end" ];

          "к" = [ "replace" ];
          "К" = [ "replace_with_yanked" ];

          "е" = [ "find_till_char" ];
          "Е" = [ "till_prev_char" ];

          "н" = [ "yank" ];

          "г" = [ "undo" ];
          "Г" = [ "redo" ];
          "A-г" = [ "earlier" ];
          "A-Г" = [ "later" ];

          "ш" = [ "insert_mode" ];
          "Ш" = [ "insert_at_line_start" ];
          "C-ш" = [ "jump_forward" ];
          "A-ш" = [ "shrink_selection" ];
          "A-Ш" = [ "select_all_children" ];

          "щ" = [ "open_below" ];
          "Щ" = [ "open_above" ];
          "C-щ" = [ "jump_backward" ];
          "A-щ" = [ "expand_selection" ];

          "з" = [ "paste_after" ];
          "З" = [ "paste_before" ];
          "A-з" = [ "select_prev_sibling" ];

          "ф" = [ "append_mode" ];
          "Ф" = [ "insert_at_line_end" ];
          "C-ф" = [ "increment" ];
          "A-ф" = [ "select_all_siblings" ];

          "ы" = [ "select_regex" ];
          "Ы" = [ "split_selection" ];
          "C-ы" = [ "save_selection" ];
          "A-ы" = [ "split_selection_on_newline" ];

          "в" = [ "delete_selection" ];
          "A-в" = [ "delete_selection_noyank" ];

          "а" = [ "find_next_char" ];
          "А" = [ "find_prev_char" ];

          "р" = [ "move_char_left" ];

          "о" = [ "move_visual_line_down" ];
          "О" = [ "join_selections" ];
          "A-О" = [ "join_selections_space" ];

          "л" = [ "move_visual_line_up" ];
          "Л" = [ "keep_selections" ];
          "A-Л" = [ "remove_selections" ];

          "д" = [ "move_char_right" ];

          "C-я" = [ "suspend" ];

          "ч" = [ "extend_line_below" ];
          "Ч" = [ "extend_to_line_bounds" ];
          "C-ч" = [ "decrement" ];
          "A-ч" = [ "shrink_to_line_bounds" ];

          "с" = [ "change_selection" ];
          "С" = [ "copy_selection_on_next_line" ];
          "A-с" = [ "change_selection_noyank" ];
          "A-С" = [ "copy_selection_on_prev_line" ];

          "м" = [ "select_mode" ];

          "и" = [ "move_prev_word_start" ];
          "И" = [ "move_prev_long_word_start" ];
          "A-и" = [ "move_parent_node_start" ];

          "т" = [ "search_next" ];
          "Т" = [ "search_prev" ];
          "A-т" = [ "select_next_sibling" ];

        };
        languages.language = [
          {
            name = "rust";
            auto-format = true;
          }
        ];
        languages.language-server = {
          tinymist.config = {
            preview.background.enabled = true;
            preview.background.args = [
              "--data-plane-host=127.0.0.1:23635"
              "--open"
            ];
            preview.invertColors = "never";
          };
          rust-analyzer.config = {
            interpret.tests = true;
          };
        };
        defaultEditor = true;
        extraPackages = with pkgs; [
          rust-analyzer
          tinymist
          clang-tools
          # omnisharp-roslyn
          texlab
          lldb
          vscode-langservers-extracted
        ];
      };
    };
}
