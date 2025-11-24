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

          # Перезаписываем скрипты при каждом входе — безопасно
          cat > "$devbin/build" << 'EOF'
          #!/usr/bin/env bash
          nixos-rebuild build --flake .#desktop && nvd diff /run/current-system result
          EOF

          cat > "$devbin/apply" << 'EOF'
          #!/usr/bin/env bash
          sudo nixos-rebuild switch --flake .#desktop
          EOF

          chmod +x "$devbin/build" "$devbin/apply"

          export PATH="$devbin:$PATH"

          echo "Nix shell ready!"
          echo "build  - nixos-rebuild + nvd diff"
          echo "apply - apply configuration (nixos-rebuild switch)"
        '';
      };
    };
}
