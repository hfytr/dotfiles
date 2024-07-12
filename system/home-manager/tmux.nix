{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    catppuccin.enable = true;

    baseIndex = 1;
    prefix = "C-Space";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      yank
      sensible
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g mouse on

      set-option -g status-position top

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind -n M-N select-window -t 1
      bind -n M-R select-window -t 2
      bind -n M-T select-window -t 3
      bind -n M-S select-window -t 4
      bind -n M-G select-window -t 5

      bind e capture-pane -S - -E - \; save-buffer /tmp/tmux_scrollback.txt \; run-shell "nvim /tmp/tmux_scrollback.txt"

      bind '"' split-window -h -c "#{pane_current_path}"
      bind % split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';

    catppuccin.extraConfig = ''
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"

      set -g @catppuccin_window_current_background "#313244"
      set -g @catppuccin_window_default_background "#313244"
      
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text  "#W"
      
      set -g @catppuccin_status_modules_right "directory user session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"

      set -g @catppuccin_flavour "mocha"
      set -g @catppuccin_status_background "default"
    '';
  };
}
