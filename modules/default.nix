{ inputs, pkgs, config, ... }:

# configs I dont want to keep in my ../home folder
{
  imports = [ ./neofetch ./hyprland ./schizofox ./vimuwu ./btm ];
}
