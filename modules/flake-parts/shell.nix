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
          nixos-rebuild build --flake .#desktop && nvd diff /run/current-system result
          EOF

          cat > "$devbin/apply" << 'EOF'
          #!/usr/bin/env bash
          sudo nixos-rebuild switch --flake .#desktop
          EOF

          chmod +x $devbin/update"" "$devbin/build" "$devbin/apply"

          export PATH="$devbin:$PATH"

          echo "Nix shell ready!"
          echo "update - nix flake update"
          echo "build - nixos-rebuild build + nvd diff"
          echo "apply - nixos-rebuild switch"
        '';
      };
    };
}
