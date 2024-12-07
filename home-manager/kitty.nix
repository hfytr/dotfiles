{ pkgs, lib, ... }: {
  programs.kitty.enable = true;

  programs.kitty.settings = {
    window_margin_width = 0;
    disable_ligatures = "always";
    dynamic_background_opacity = false;

    copy_on_select = true;
    confirm_os_window_close = 0;
    term = "xterm-256color";
    shell_integration = "no-rc";
    clear_all_shortcuts = true;
  };

  programs.kitty.keybindings = {
    "ctrl+shift+v" = "paste_from_clipboard";
  };

  programs.kitty.extraConfig = ''
    font_family JetBrainsMono NFM Thin
    bold_font JetBrainsMono NFM ExtraLight
    bold_italic_font JetBrainsMono NFM ExtraLight Italic
    italic_font auto
    font_size 7
  '';
}
