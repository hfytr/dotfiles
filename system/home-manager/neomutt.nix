{ pkgs, lib, ... }: {
  accounts.email.accounts.personal = {
    primary = true;
    flavor = "gmail.com";
    realName = "Archim Jhunjhunwala";
    address = "archim.jhunjhunwala@gmail.com";
    userName = "archim.jhunjhunwala@gmail.com";
    passwordCommand = "cat ~/.private/gmailpass.txt";
    maildir.path = "personal";
    neomutt.enable = true;
  };

  programs.neomutt.enable = true;
}
