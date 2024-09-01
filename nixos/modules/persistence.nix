{ ... }:

{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/fprint"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      {
        # This is a workaround for the issue described here:
        # https://discourse.nixos.org/t/nix-with-flakes-does-not-recognise-home-config-nix-registry-json/30018/18
        directory = "/etc/nix";
        user = "root";
        group = "root";
        mode = "u=rwx,g=rx,o=rx";
      }
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/wireguard/keys/private"
      "/etc/wireguard/keys/preshared"
    ];
    users.gerwin = {
      directories = [
        ".cache/ncspot"
        ".config/1Password"
        ".config/github-copilot"
        ".local/share/keyrings"
        ".mozilla"
        ".gnupg"
        ".ssh"
        "code"
        "work"
      ];
      files = [
        ".aws/credentials"
        ".bash_history"
        ".cargo/credentials.toml"
      ];
    };
  };
}
