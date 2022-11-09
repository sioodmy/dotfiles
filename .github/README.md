

<h1 align="center">
  <img src="https://camo.githubusercontent.com/8c73ac68e6db84a5c58eef328946ba571a92829b3baaa155b7ca5b3521388cc9/68747470733a2f2f692e696d6775722e636f6d2f367146436c41312e706e67" width="100px" /> <br>
  
  sioodmy's dotfiles <br>
  <img src="../assets/colors.png" width="600px" /> <br>
  <div align="center">

  <div align="center">
   <p></p>
   <a href="">
      <img src="https://img.shields.io/github/issues/sioodmy/dotfiles?color=fab387&labelColor=1e1e2e&style=for-the-badge">
   </a>
   <a href="https://github.com/sioodmy/dotfiles/stargazers">
      <img src="https://img.shields.io/github/stars/sioodmy/dotfiles?color=cba6f7&labelColor=1e1e2e&style=for-the-badge">
   </a>
   <a href="https://github.com/sioodmy/dotfiles/">
      <img src="https://img.shields.io/github/repo-size/sioodmy/dotfiles?color=eba0ac&labelColor=1e1e2e&style=for-the-badge">
   </a>

  <img alt="" src="https://badges.pufler.dev/visits/sioodmy/dotfiles?style=for-the-badge&color=a6e3a1&logoColor=white&labelColor=1e1e2e"/>
   <br>
</div>
</h1>

<br>
</div>

<p align="center">
<img src="https://media.discordapp.net/attachments/1020403449092911186/1024341925630844939/unknown.png?width=1122&height=631" width="700" alt="" />
<img src="https://cdn.discordapp.com/attachments/635625917623828520/1026557593767903292/nvim.png?width=1122&height=631" width="700" alt="" />
<img src="https://media.discordapp.net/attachments/635625917623828520/1028413483580137503/unknown.png?width=1158&height=631" width="700" alt="" />
</p>

> **Disclaimer:** _This is not a community framework or distribution._ It's a
> private configuration and an ongoing experiment to feel out NixOS. I make no
> guarantees that it will work out of the box for anyone but myself. It may also
> change drastically and without warning. 
> 
> Until I can bend spoons with my nix-fu, please don't treat me like an
> authority or expert in the NixOS space. Seek help on [the NixOS
> discourse](https://discourse.nixos.org) instead.


|                |                                                          |
|----------------|----------------------------------------------------------|
| **Shell:**     | zsh                                                      |
| **WM:**        | Hyprland + Waybar                                        |
| **Editor:**    | vimuwu                                                   |
| **Terminal:**  | kitty                                                    |
| **Launcher:**  | rofi                                                     |
| **Browser:**   | Schizofox                                                |
| **Channel:**   | nixos-unstable                                           |
| **Theme:** | Catppuccin                                                   |

# Installation
Here are the installation instructions for my configuration.
I wrote this so you don't forget it in the future, please don't install it "as is".
Make your own configuration. 

<img src="https://github.com/sioodmy/dotfiles/actions/workflows/check.yml/badge.svg" />

>How to get started?

Use google and find out for yourself, you'll get used to it.

:fire: Welcome to the undocumented hell of NixOS. 

Good luck and ~~have fun~~
1. **Read the disclaimer** (tldr: use your own configuration or I will have ssh keys for your machine)

2. Download iso
   ```sh
   # Yoink nixos-unstable
   wget -O nixos.iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso
   
   # Write it to a flash drive
   cp nixos.iso /dev/sdX
   ```

3. Boot into the installer.

4. Switch to root user: `sudo su -`
  
5. Partitioning

    We create a 512MB EFI boot partition (`/dev/sda1`) and the rest will be our LUKS encrypted physical volume for LVM (`/dev/sda2`).
    ```
    $ gdisk /dev/sda
    ```
    - `o` (create new empty partition table)
    - `n` (add partition, 512M, type ef00 EFI)
    - `n` (add partition, remaining space, type 8300 Linux LVM)
    - `w` (write partition table and exit)
    
    Setup the encrypted LUKS partition and open it:
    ```
    $ cryptsetup luksFormat /dev/sda2
    $ cryptsetup config /dev/sda2 --label cryptroot
    $ cryptsetup luksOpen /dev/sda2 enc-pv
    ```
    We create two logical volumes, a 16GB swap parition and the rest will be our root filesystem
    ```
    $ pvcreate /dev/mapper/enc-pv
    $ vgcreate vg /dev/mapper/enc-pv
    $ lvcreate -L 16G -n swap vg
    $ lvcreate -l '100%FREE' -n root vg
    ```
    Format paritions
    ```
    $ mkfs.fat /dev/sda1 -n boot
    $ mkfs.ext4 -L root /dev/vg/root
    $ mkswap -L swap /dev/vg/swap
    ```
    Mount paritions
    ```
    $ mount /dev/vg/root /mnt
    $ mkdir /mnt/boot
    $ mount /dev/sda1 /mnt/boot
    $ swapon /dev/vg/swap
    ```
    
6. Fix "too many files open"
    
    ```
    $ ulimit -n 500000
    ```
7. Enable flakes
    ```
    $ nix-shell -p nixFlakes
    ```
    
8. Install nixos from flake
    ```
    $ nixos-install --flake github:sioodmy/dotfiles#graphene --impure
    ```
<div align="center">

<br clear="right"/>
 <div align="left">
 <h3>Misc</h3>
 <a href="../modules/schizofox">Schizofox</a>
    <h3> ♥️ Thanks to</h3>
   <ul>
     <li><a href="https://github.com/siduck">siduck</a></li>
     <li><a href="https://github.com/rxyhn">rxyhn</a></li>
     <li><a href="https://github.com/fufexan">fufexan</a></li>
     <li><a href="https://github.com/NobbZ">NobbZ</a></li>
     <li><a href="https://github.com/hlissner">hlissner</a></li>
     <li><a href="https://github.com/pupbrained">pupbrained</a></li>
     <li><a href="https://github.com/notusknot">notusknot</a></li>
     <li><a href="https://github.com/Tanish2002">Tanish2002</a></li>
     <li><a href="https://github.com/AlphaTechnolog">AlphaTechnolog</a></li>
     <li><a href="https://github.com/owl4ce">owl4ce</a></li>
     <li><a href="https://gitlab.com/luca.py/">luca.py</a></li>
     <li><a href="https://github.com/JavaCafe01">JavaCafe</a></li>
     <li><a href="https://github.com/FromSyntax">FromSyntax</a></li>
     <li><a href="https://discord.gg/Rk8VsHef3G">NixOS discord community</li>
   </ul>
  </div>
<br />
<i>I would kill for a framework laptop</i>
<pre>
ETH: 0x430de39c494E40808F9d8A50958Eec622C3B5577
</pre>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/c9d3d7de6ab8cb2609b37c4b79b026a2c7784b6f/assets/footers/gray0_ctp_on_line.svg?sanitize=true" alt="" /> <br />
  Copyright © 2021-present <a href="https://github.com/sioodmy">sioodmy</a>
  <p align="center"><a href="https://github.com/sioodmy/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPL-3&logoColor=d9e0ee&colorA=313244&colorB=cba6f7"/></a></p>
