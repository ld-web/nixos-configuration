# NixOS Configuration

## Fonts

Put all files in the `fonts/` folder in `~/.local/share/fonts`, then execute `fc-cache -vf`

## 2024/12: Cursor IDE in unstable channel

To be able to install Cursor, add the unstable channel to nix channels :

```bash
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
```

