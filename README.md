# Nix Configuration

This repository contains my personal Nix configuration organized using a dendritic structure.

## Dendritic Structure

A dendritic approach structures configuration modules in a branching, tree-like pattern. This makes the setup:

- Highly modular
- Reusable across different systems
- Cleanly separated by concerns
- Easier to maintain and extend

## 🖥️ Hosts

| Hostname    | Description | Device | Disko Support |
| ----------- | ----------- | ------ | :-----------: |
| `desktop`   | Main Workstation (Plasma) | PC | ❌ (Manual) |
| `redmibook` | Laptop | RedmiBook | ❌ (Manual) |
| `vm`        | Testing VM | QEMU/KVM | ✅ |

## 🚀 Deployment

### Option 1: Automated Remote Deployment (nixos-anywhere)

This method automatically partitions the disk, installs the system, and reboots. Ideal for new servers or VMs.
*Note: The target host must have a `disko` configuration (currently enabled for `vm`).*

1. **Boot the target machine** into the NixOS installer.
2. **Run the deployment** from your local machine:

```bash
# Replace <hostname> with the target host (e.g., vm) and <target-ip> with its IP address
nix run github:nix-community/nixos-anywhere -- --flake .#<hostname> root@<target-ip>
```

> **Note on Secrets:** Since this config uses `sops-nix`, you need to copy your keys to the target machine. Use the `--extra-files` flag:
>
> ```bash
> nix run github:nix-community/nixos-anywhere -- \
>   --extra-files ./secrets-dir \
>   --flake .#vm root@192.168.1.50
> ```

### Option 2: Manual Installation (using Disko)

This method assumes you are booted into a NixOS Live ISO with internet access.

1. **Partition the disks** using the flake's Disko configuration:

```bash
# Partition, format, and mount drives automatically
nix run github:nix-community/disko -- --mode disko --flake github:kexan/nix-cfg#<hostname>
```

2. **Install NixOS**:

```bash
# Install the system to the /mnt directory mounted by Disko
nixos-install --flake github:kexan/nix-cfg#<hostname>
```

### 3. Sops Key Injection (Manual)

If you are installing manually and have enabled `sops`, you must place the AGE key on the target system before the first boot.

```bash
sudo mkdir -p /mnt/var/lib/sops-nix/
# Copy your key (assuming it's on a mounted USB drive or downloaded)
sudo cp /path/to/key.txt /mnt/var/lib/sops-nix/key.txt
sudo chmod 600 /mnt/var/lib/sops-nix/key.txt
```

<details>
<summary><h2>How to fork and use this configuration</h2></summary>

If you want to use this repository as a base for your own NixOS configuration, follow these steps.

### 1. User Configuration
This configuration is set up for the user `kexan`.
1. Create a new user module in `modules/users/<your-username>` (you can copy `modules/users/kexan` as a template).
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

</details>

## References

- [dendritic](https://github.com/mightyiam/dendritic) — the original dendritic configuration pattern.
- [Dendrix](http://dendrix.oeiuwq.com/index.html) — a community-driven distribution of dendritic Nix configurations.
- [Pol Dellaiera's Configuration](https://github.com/drupol/infra) — a dendritic-style setup that inspired this repository.
- [Doc-Steve's Dendritic Design Guide](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
