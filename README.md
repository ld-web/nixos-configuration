# NixOS Configuration

## Fonts

Put `jf-openhuninn-2.1.ttf` in `~/.local/share/fonts`, then execute `fc-cache -vf`

## 2024/12: Cursor IDE in unstable channel

To be able to install Cursor, add the unstable channel to nix channels :

```bash
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
```

