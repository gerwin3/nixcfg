{ ... }:

{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 900;
        command = "swaylock";
      }
    ];
  };
}
