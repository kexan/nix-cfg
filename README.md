# Nix Configuration

This repository contains my personal Nix configuration organized using a dendritic structure.

## Dendritic Structure

A dendritic approach structures configuration modules in a branching, tree-like pattern. This makes the setup:

- Highly modular
- Reusable across different systems
- Cleanly separated by concerns
- Easier to maintain and extend

<details>
<summary><h2>How to fork and use this configuration</h2></summary>

If you want to use this repository as a base for your own NixOS configuration, follow these steps.

### 1. User Configuration
This configuration is set up for the user `kexan`.
1. Rename `modules/users/kexan` to `modules/users/<your-username>`.
2. Update the references in `modules/hosts/<host>/default.nix` to import your new user module instead of `kexan`.
3. Update `modules/users/<your-username>/default.nix` with your real name, email, and SSH keys.

### 2. Reset Secrets (Sops)
You cannot use the existing `secrets/secrets.yaml` because it is encrypted with my keys.

1. **Delete existing secrets:**
   ```bash
   rm secrets/secrets.yaml
   ```

2. **Generate your Age key:**
   ```bash
   mkdir -p ~/.config/sops/age
   age-keygen -o ~/.config/sops/age/keys.txt
   ```

3. **Update Configuration:**
   *   Get your public key (it starts with `age1...` in the `keys.txt` file).
   *   Edit `.sops.yaml`: Replace my keys with your new public key.

4. **Recreate Secrets:**
   Create a new secrets file with the required structure:
   ```bash
   sops secrets/secrets.yaml
   ```
   (Add the necessary keys like `ssh_key` referenced in user config).

### 3. Hardware & Disko
1. **Disko**: Edit `modules/hosts/<host>/disko.nix` to match your drive name (e.g., `/dev/nvme0n1` or `/dev/sda`).
2. **Install**: Follow the Installation guide below, but use your own fork URL.

</details>

## Installation (Remote Flake)

This guide assumes you are booted into a NixOS Live ISO with internet access.
You **do not** need to clone the repository manually.

### 1. Networking

Connect to the internet:

```bash
nmtui
# or
wpa_supplicant -B -i wlan0 -c <(wpa_passphrase 'SSID' 'password')
```

### 2. Disk Partitioning (Disko)

You can run `disko` directly from the remote flake.
Replace `<hostname>` with your target host name defined in the flake (e.g., `redmibook` or `desktop`).

```bash
# Partition, format, and mount drives automatically
# NOTE: This will wipe the disk defined in the host configuration!
nix run github:nix-community/disko -- --mode disko --flake github:kexan/nix-cfg#<hostname>
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

Install directly from the GitHub repository:

```bash
nixos-install --flake github:kexan/nix-cfg#<hostname>
```

Reboot and enjoy!

## References

- [dendritic](https://github.com/mightyiam/dendritic) — the original dendritic configuration pattern.
- [Dendrix](http://dendrix.oeiuwq.com/index.html) — a community-driven distribution of dendritic Nix configurations.
- [Pol Dellaiera's Configuration](https://github.com/drupol/infra) — a dendritic-style setup that inspired this repository.
- [Doc-Steve's Dendritic Design Guide](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
