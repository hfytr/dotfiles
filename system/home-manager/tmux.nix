{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    prefix = "C-Space";
    keyMode = "vi";
    newSession = true;

    plugins = with pkgs.tmuxPlugins; [
      yank
      sensible
      resurrect
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g mouse on

      set-option -g status-position top

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind -n M-Y select-pane -L
      bind -n M-H select-pane -D
      bind -n M-A select-pane -U
      bind -n M-E select-pane -R

      bind -n C-M-Y resize-pane -L 10
      bind -n C-M-H resize-pane -D 10
      bind -n C-M-A resize-pane -U 10
      bind -n C-M-E resize-pane -R 10

      bind -n M-C new-window
      bind -n M-Z resize-pane -Z

      bind -n M-N select-window -t 1
      bind -n M-R select-window -t 2
      bind -n M-T select-window -t 3
      bind -n M-S select-window -t 4
      bind -n M-G select-window -t 5

      bind e capture-pane -S - -E - \; save-buffer /tmp/tmux_scrollback.txt \; split-window 'nvim /tmp/tmux_scrollback.txt'
      bind h copy-mode

      bind '"' split-window -h -c "#{pane_current_path}"
      bind % split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -ag status-right  "#{E:@catppuccin_status_directory}"
      set -ag status-right  "#{E:@catppuccin_status_user}"
      set -ag status-right  "#{E:@catppuccin_status_session}"
    '';

    catppuccin.extraConfig = ''
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_window_number_position "right"

      set -g @catppuccin_window_current_number_color "#a6e3a1"
      set -g @catppuccin_window_current_number_color "#89b4fa"

      set -g @catppuccin_pane_border_style "fg=#89b4fa"
      set -g @catppuccin_pane_active_border_style "fg=#a6e3a1"
      
      set -g @catppuccin_window_text "#W"
      set -g @catppuccin_window_current_text  "#W"
      
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "yes"

      set -g @catppuccin_flavour "mocha"
      set -g @catppuccin_status_background "none"
    '';
  };
}
