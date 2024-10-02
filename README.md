# Nixus

## Contents

This repo contains my reorganized and rewritten NixOS configuration.
It might not be widely considered _correct_ or whatever, because I used some of my braincells to come up with this autistic design philosophy:

- **Do not overengineer** - Yeah, we get it, you are good at Nix, but you don't really need to overcomplicate everything. You sacrifice both readability and evaluation times in exchange for absolutely nothing
  > An idiot admires complexity, a genius admires simplicity, a physicist tries to make it simple, for an idiot anything the more complicated it is the more he will admire it, if you make something so clusterfucked he can't understand it he's gonna think you're a god cause you made it so complicated nobody can understand it. That's how they write journals in Academics, they try to make it so complicated people think you're a genius
  > ~ Terry Davis, Creator of Temple OS
- **No inputs other than nixpkgs** - This is probably the most controversial one, for me it's just a proof of concept that you can achieve behaviour provided by external modules in a much simpler way. Just straight up rawdogging nix
- Wrap binaries rather than creating user modifable files in home directory, just to be _pure_ ™️
- Avoid `with` keyword at ALL COST
- Disk partitioning should not be declarative, I don't like the way disko does it. I use same partition layout for all of my hosts, and that's enough.
- I like to keep my secrets in one place that is not my repo

# Why I don't use some of the popular NixOS modules?

## Home-manager

I don't like it. I prefer to wrap my binaries and use systemd tmpfiles instead. Much better solution.

Everyone in nix community will tell you that hm is a mess.

## Flake-parts

Actually I have nothing against using flake-parts, although I don't see the use case in my NixOS configuration since I only use one cpu architecture.

Trust me, I tried. It never compiles on ARM anyway

## Impermanence

Bind mounts are somewhat unreliable at best and lead to undefined behaviour. Again, systemd-tmpfiles on top

## Nix-colors

It's just a glorified attribute set

## 💛 Donate

If you would like to support me you can sponsor me via ko-fi

<a href="https://ko-fi.com/sioodmy"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support me on kofi" /> </a>

... or if you prefer crypto

Ethereum/EVM compatible: `0x2fa1e5e90c011d08bba1f6dbdc317fd293311c0d`

[![Star History Chart](https://api.star-history.com/svg?repos=sioodmy/dotfiles&type=Date)](https://star-history.com/#sioodmy/dotfiles&Date)
