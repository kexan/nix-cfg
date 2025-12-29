# Nix Configuration

This repository contains my personal Nix configuration organized using a dendritic structure.

## Dendritic Structure

A dendritic approach structures configuration modules in a branching, tree-like pattern. This makes the setup:

- Highly modular
- Reusable across different systems
- Cleanly separated by concerns
- Easier to maintain and extend

## Installation

This guide assumes you are booted into a NixOS Live ISO.

### 1. Networking

Connect to the internet:

```bash
nmtui
# or
wpa_supplicant -B -i wlan0 -c <(wpa_passphrase 'SSID' 'password')
```

### 2. Disk Partitioning (Disko)

This configuration uses `disko` for declarative partitioning.

```bash
# Clone the repository
git clone https://github.com/kexan/nix-cfg /mnt/etc/nixos

# Run disko to partition, format, and mount drives
# Replace 'redmibook' with your target host and adjust the path to disko.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /mnt/etc/nixos/modules/hosts/redmibook/disko.nix
```

### 3. Sops Key Injection

Before installing, you must manually place the `age` key on the target system so `sops-nix` can decrypt secrets on the first boot.

1.  Plug in your external drive containing `key.txt`.
2.  Mount it (e.g., to `/media`).
3.  Copy the key to the target location:

```bash
sudo mkdir -p /mnt/var/lib/sops-nix/
sudo cp /media/key.txt /mnt/var/lib/sops-nix/key.txt
sudo chmod 600 /mnt/var/lib/sops-nix/key.txt
```

### 4. Install NixOS

Run the installation using the flake:

```bash
nixos-install --flake /mnt/etc/nixos#redmibook
```

Reboot and enjoy!

## References

- [dendritic](https://github.com/mightyiam/dendritic) — the original dendritic configuration pattern.
- [Dendrix](http://dendrix.oeiuwq.com/index.html) — a community-driven distribution of dendritic Nix configurations.
- [Pol Dellaiera's Configuration](https://github.com/drupol/infra) — a dendritic-style setup that inspired this repository.
- [Doc-Steve's Dendritic Design Guide](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
