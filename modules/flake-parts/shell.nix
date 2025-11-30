{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nvd
        ];

        shellHook = ''
          devbin="$PWD/.direnv/devbin"
          mkdir -p "$devbin"

          cat > "$devbin/update" << 'EOF'
          #!/usr/bin/env bash
          nix flake update
          EOF

          cat > "$devbin/build" << 'EOF'
          #!/usr/bin/env bash
          if [ $# -eq 0 ]; then
            echo "Usage: build <hostname>"
            exit 1
          fi
          hostname="$1"
          nixos-rebuild build --flake ".#$hostname" && nvd diff /run/current-system ./result
          EOF

          cat > "$devbin/apply" << 'EOF'
          #!/usr/bin/env bash
          if [ $# -eq 0 ]; then
            echo "Usage: apply <hostname>"
            exit 1
          fi
          hostname="$1"
          sudo nixos-rebuild switch --flake ".#$hostname"
          EOF

          chmod +x "$devbin/update" "$devbin/build" "$devbin/apply"

          export PATH="$devbin:$PATH"

          echo "Nix shell ready!"
          echo "update            — nix flake update"
          echo "build <hostname>  — nixos-rebuild build + nvd diff"
          echo "apply <hostname>  — nixos-rebuild switch"
        '';
      };
    };
}
