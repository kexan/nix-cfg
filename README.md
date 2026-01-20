# Nix Configuration

This repository contains my personal Nix configuration organized using a dendritic structure.

<img width="3840" height="2160" alt="desktop screenshot" src="https://github.com/user-attachments/assets/634df37c-4f15-4765-9768-5e4e1ab36d47" />

## ❄️ Dendritic Structure

A dendritic approach structures configuration modules in a branching, tree-like pattern. This makes the setup:

- Highly modular
- Reusable across different systems
- Cleanly separated by concerns
- Easier to maintain and extend

## 🧩 Modules Overview

My configuration distinguishes between three types of modules based on their scope.

| Type | Description | Modules |
| :--- | :--- | :--- |
| **Shared**<br>*(Hybrid)* | Features with both system and user components. <br>• **NixOS import:** Configures system + user env.<br>• **HM import:** Configures user env only. | `gnome`, `kexan`, `niri`, `plasma`, `shell` |
| **NixOS Only**<br>*(System)* | System services, hardware, networking, and virtualization. Cannot be used in standalone HM. | `base`, `btrfs`, `corectrl`, `desktop`, `docker`, `gaming`, `jellyfin`, `openssh`, `podman`, `sops`, `sound`, `virtualbox`, `vpn`, `winbox` |
| **Home Manager Only**<br>*(User)* | User-space apps and configs. Universal, works on any Linux/macOS with HM. | `ai`, `lazyvim`, `messaging`, `retroarch`, `zen-browser` |

> **⚠️ Shared Modules** act as "full-stack" bundles. When you import a shared module (e.g., `plasma`) into a NixOS configuration, it **automatically configures** the corresponding Home Manager settings for users.
>
> *   **On NixOS:** Import **ONLY** the NixOS module. Do not import the HM module manually to avoid conflicts.
> *   **On Standalone Home Manager:** You can safely import the HM part of a shared module to get the user-space configuration (without system-level services).


## 📝 Configuration Example

Here is the actual configuration for the `desktop` host. It demonstrates how to assemble a system using the modular structure.

Note how **System/Shared** modules are imported directly, while **Home Manager Only** modules (like `lazyvim` or `zen-browser`) are injected specifically into the user's scope.

```nix
flake.modules.nixos."hosts/desktop" = {
  imports =
    with config.flake.modules.nixos;
    [
      # --- Core & System ---
      base
      shell
      openssh
      sops
      #btrfs

      # --- Hardware ---
      sound
      corectrl

      # --- Desktop Environment ---
      desktop
      plasma
      flatpak

      # --- Network ---
      vpn
      winbox

      # --- Virtualization ---
      virtualbox

      # --- Gaming ---
      gaming

      # --- Services ---
      jellyfin

      # --- Users ---
      kexan
    ]

    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.kexan = {
          imports = with config.flake.modules.homeManager; [
            ai
            lazyvim
            messaging
            retroarch
            zen-browser
          ];
        };
      }
    ];
};
```

## 🛠️ Development Workflow

This flake includes a pre-configured `devShell` with custom aliases to simplify daily operations.
Just enter the directory (with `direnv` enabled) or run `nix develop` to access them.

| Command | Description | Under the hood |
| :--- | :--- | :--- |
| `modules` | **List all available modules**<br>Scans the flake structure and groups modules by type (Shared, NixOS, Home Manager). | `nix eval` + `jq` magic |
| `apply [host]` | **Apply configuration**<br>Rebuilds and switches the system. Defaults to current hostname if argument omitted. | `nh os switch -H <host>` |
| `build [host]` | **Build without switching**<br>Use this to test if your code compiles correctly. | `nh os build -H <host>` |
| `boot [host]` | **Build and set as boot**<br>Updates the bootloader entry without switching runtime immediately. | `nh os boot -H <host>` |
| `update` | **Update flake inputs**<br>Updates `flake.lock` to the latest versions. | `nix flake update` |
| `check` | **Verify flake integrity**<br>Runs checks to ensure the flake is valid. | `nix flake check` |
| `sops <file>` | **Edit secrets**<br>Opens the encrypted file with your `$EDITOR`. Automatically handles keys location. | `sops <file>` |

> **Tip:** You don't need to specify `[host]` if you are running the command on the target machine itself.
>
> Example: Running `apply` on the machine named **desktop** is equivalent to running `apply desktop` (or `nh os switch -H desktop`).


<details>
<summary><h2>🚀 Deployment</h2></summary>

### Option 1: Automated Remote Deployment (nixos-anywhere)

This method automatically partitions the disk, installs the system, and reboots. Ideal for new installs or VMs.
*Note: The target host must have a `disko` configuration*

1. **Boot the target machine** into the NixOS installer.
2. **Run the deployment** from your local machine:

```bash
# Replace <hostname> with the target host (e.g., desktop) and <target-ip> with its IP address
nix run github:nix-community/nixos-anywhere -- --flake .#<hostname> nixos@<target-ip>
```

> **Note on Secrets:** If the target host uses `sops-nix` (imports the `sops` module), you must inject the decryption keys during deployment.
> 
> Create a directory with the correct file structure (e.g., `my-keys/var/lib/sops-nix/key.txt`) and pass it using the `--extra-files` flag:
>
> ```
> # Ensure the directory structure inside matches the target filesystem
> # Example: my-keys/var/lib/sops-nix/key.txt
> nix run github:nix-community/nixos-anywhere -- \
>   --extra-files ./my-keys \
>   --flake .#<hostname> root@<target-ip>
> ```

### Option 2: Manual Installation (using Disko)

This method assumes you are booted into a NixOS Live ISO with internet access.
*Note: The target host must have a `disko` configuration*

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
</details>

<details>
<summary><h2>🍴 How to fork and use this configuration</h2></summary>

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
   mkdir -p ~/.config/sops
   age-keygen -o ~/.config/sops/key.txt
   ```

3. **Update Configuration:**
   *   Get your public key (it starts with `age1...` in the `key.txt` file).
   *   Edit `.sops.yaml`: Replace my keys with your new public key.

4. **Recreate Secrets:**
   Create a new secrets file with the required structure:
   ```bash
   sops secrets/secrets.yaml
   ```

   For example, ensure you define `users/kexan/password` as a **hashed** password (e.g., `mkpasswd -m sha-512`) for the `kexan` user.
   ```bash
   mkpasswd -m sha-512
   ```

</details>

## References

- [dendritic](https://github.com/mightyiam/dendritic) — the original dendritic configuration pattern.
- [Dendrix](http://dendrix.oeiuwq.com/index.html) — a community-driven distribution of dendritic Nix configurations.
- [Pol Dellaiera's Configuration](https://github.com/drupol/infra) — a dendritic-style setup that inspired this repository.
- [Doc-Steve's Dendritic Design Guide](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
