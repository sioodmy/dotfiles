{
  config,
  pkgs,
  ...
}: {
  users.users.sioodmy = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gitea"
      "systemd-journal"
      "audio"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "changeme";
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfzq3529yMLJyBRswtnQixoJnKjIimbF831W6K56i7JN+XE2P+BAhena83HWOrQx/Y0KF17s2R7Ub5IiksotUIeA/UwnZUqvLWge1JEuwM6ZuTm042iGVy+IMi1zxltKnexbDkH2gc2bvcSZsl2L7jVjnykjOa+MwSG1rC8wavneGCzmEVKJmdk6kq7rCgLIH2Hr56sBpJBYtP179jT8L39nC/IxtPKtfv42OAWjp8HYKF0PFua+J2teAYSg9NPtBbogQ0LuR9nfw19g7Sj4+Um9z2QnYmp+9QIbJAzzn3eEQx8tfx0ziD/j7jk9g0FvJiP457bzz3/2Wv4jnMu54bkGV1XrjOjXT8vH7IxjxlFrKpCOZYjNZ227SPFKb6DCUGHrtZmlzjBQ0mh1d0mSVIaUmiemq/fuoSM8CJrNAkrt9ztxEh6fZ90qS4YC9UlhfUjx1C5I3osa7RNMzSqbzpiqmSmqLRiVdRVQlt1gObzVu5b37rMoM0EfoXFcJbXes= sioodmy@graphene"];
  };
}
