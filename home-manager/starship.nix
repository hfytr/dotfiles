{ pkgs, lib, ... }: {
  programs.starship.enable = true;
  programs.starship.settings = {
    format = ''
      [╭─](red)[\($username@$hostname\)](blue bold) $directory$package$git_branch$git_status$git_state$cmd_duration
      [╰─](red)$character
    '';
    username.show_always = true;
    username.format = "$user";
    hostname.ssh_only = false;
    hostname.format = "$ssh_symbol$hostname";

    add_newline = false;
  };
}
