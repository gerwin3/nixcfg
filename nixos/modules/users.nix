{ ... }:

{
  users.mutableUsers = false;
  users.users.gerwin = {
    isNormalUser = true;
    hashedPassword = builtins.readFile ../../secrets/password;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.extraRules = [
    {
      users = [ "gerwin" ];
      commands = [
        {
          command = "ALL";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }
  ];
}
