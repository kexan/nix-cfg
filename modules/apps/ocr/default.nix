{ inputs, ... }:

{
  flake.modules = {
    homeManager.ocr =
      {
        lib,
        config,
        pkgs,
        ...
      }:

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
            pkgs.websocat
            pkgs.coreutils
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

            if command -v websocat >/dev/null 2>&1; then
              printf '%s' "$text" | timeout 2s websocat -1 -t ws://127.0.0.1:6677 >/dev/null 2>&1 || true
            fi

            if command -v notify-send >/dev/null 2>&1; then
              chars="''${#text}"
              preview=$(echo "$text" | cut -c1-50)
              notify-send "OCR Готово" "Скопировано $chars символов: $preview..." 2>/dev/null || true
            fi

            rm -f "$TEMP_IMG" "$TEMP_JSON"
          '';
        };

        plasmaEnabled = config.programs.plasma.enable or false;
      in
      {
        home.packages = [
          nbocr
          ocr
        ];

        systemd.user.services.ocr-ws = {
          Unit = {
            Description = "OCR WebSocket broadcast server (ws://127.0.0.1:6677)";
            After = [ "network.target" ];
          };
          Service = {
            ExecStart = "${pkgs.websocat}/bin/websocat -t ws-l:127.0.0.1:6677 broadcast:mirror:";
            Restart = "always";
            RestartSec = 1;
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
        };

        programs.plasma = lib.mkIf plasmaEnabled {
          shortcuts = {
            "services/net.local.ocr.desktop"._launch = "Meta+O";
          };
        };
      };
  };
}
