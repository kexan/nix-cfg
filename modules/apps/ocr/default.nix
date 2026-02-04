{
  flake.modules = {
    nixos.ocr =
      { inputs, pkgs, ... }:

      let
        nbocr = inputs.newbee-ocr.packages.${pkgs.stdenv.hostPlatform.system}.newbee-ocr-cli;

        ocr = pkgs.writeShellApplication {
          name = "ocr";
          runtimeInputs = [
            nbocr
            pkgs.flameshot
            pkgs.jq
            pkgs.wl-clipboard
            pkgs.libnotify
            pkgs.coreutils
            pkgs.gnused
          ];
          text = ''
            set -euo pipefail

            CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/ocr"
            mkdir -p "$CACHE_DIR"
            TEMP_IMG="$CACHE_DIR/screenshot.png"
            TEMP_JSON="$CACHE_DIR/result.json"

            if ! flameshot gui --path "$TEMP_IMG" 2>/dev/null; then
              echo "Скриншот отменен" >&2
              exit 1
            fi

            nbocr recognize -f json --precision fast -o "$TEMP_JSON" "$TEMP_IMG" 2>/dev/null || {
              echo "OCR failed" >&2
              exit 1
            }

            text=$(jq -r '.results // [] | map(.text) | join(" ")' "$TEMP_JSON" \
              | tr '\n' ' ' \
              | sed 's/  */ /g; s/^ *//; s/ *$//')

            if [ -z "$text" ] || [ "$text" = "null" ]; then
              rm -f "$TEMP_IMG" "$TEMP_JSON"
              exit 0
            fi

            echo -n "$text" | wl-copy
            echo "$text"

            if command -v notify-send >/dev/null 2>&1; then
              chars="''${#text}"
              preview=$(echo "$text" | cut -c1-50)
              notify-send "OCR Готово" "Скопировано $chars символов: $preview..." 2>/dev/null || true
            fi

            rm -f "$TEMP_IMG" "$TEMP_JSON"
          '';
        };
      in
      {
        environment.systemPackages = [
          nbocr
          ocr
        ];
      };
  };
}
