![screenshot](assets/screenshot.png)

# ❄️ NixOS configuration

This is my NixOS configuration, which I use as my daily driver. It aims to be fast and lightweight without any weirdo-cockless type compromises (like no scrolling in terminal bruh)

> ⚠️ Note that since this configuration is designed just for me and my hardware, you may need to change some things to make it work on your device
> If you really want to use it on your machine, I recomend forking this repo.

# Installation 

## ❄️ Already running NixOS system

``` 
$ git clone https://github.com/sioodmy/nixdots && cd nixdots
$ nix-shell
$ nixos-rebuild switch --flake .#
```
Aforementioned command will automatically install appropriate configuration for your host, however you may need to use 

```
nixos-rebuild switch --flake .#graphene                 # You can replace graphene with other predefined hostname
```


## 🧹 Clean
1. [Download](https://nixos.org/download.html#download-nix) NixOS ISO
2. [Partition, format and mount your drive](https://nixos.org/manual/nixos/stable/index.html#sec-installation-partitioning)
3. Install flake `nixos-install --flake github:sioodmy/nixdots`

# Usage 

|  ⌨️ Keybinds                          |
-----------------------------------------
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Space</kbd | asdads 
  
| Key | Action |
|---|---|
| <kbd>Super</kbd> + <kbd>Enter</kbd> | Open terminal |
| <kbd>Alt</kbd> + <kbd>Grave</kbd> | Dropdown terminal |
| <kbd>Super</kbd> + <kbd>Space</kbd> | Application luncher |
| <kbd>Alt</kbd> + <kbd>Tab</kbd> | Window switcher |
| <kbd>Super</kbd> + <kbd>E</kbd> | File manager |
| <kbd>Super</kbd> + <kbd>C</kbd> | Quick calculator |
| <kbd>Super</kbd> + <kbd>period</kbd> | Emoji picker |
| <kbd>Prtscr</kbd> | Screenshot tool |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> | Lock screen |
| <kbd>Super</kbd> + <kbd>Volume up</kbd> | Increase mpd volume |
| <kbd>Super</kbd> + <kbd>Volume down</kbd> | Decrease mpd volume |
| <kbd>Super</kbd> + <kbd>Alt</kbd> + <kbd>R</kbd> | Restart bspwm |
| <kbd>Alt</kbd> + <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>h, j, k, l</kbd> | Resize focused window |
| <kbd>Super</kbd> + <kbd>W</kbd> | Close focused window |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd> | Kill focused window |
| <kbd>Super</kbd> + <kbd>M</kbd> | Alternate between the tiled and monocle layout |
| <kbd>Super</kbd> + <kbd>Y</kbd> | Send the newest marked node to the newest preselected node |
| <kbd>Super</kbd> + <kbd>h</kbd> | Swap the current node and the biggest window |
| <kbd>Super</kbd> + <kbd>T</kbd> | Tiled layout |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd | Pseudo-tiled layout | 
| <kbd>Super</kbd> + <kbd>S</kbd> | Floating mode |
| <kbd>Super</kbd> + <kbd>F</kbd> | Fullscreen mode |
