{inputs, ...}: {
  den.aspects.apps.provides.ocr = {
    nixos = {
      nixpkgs.overlays = [
        (final: prev: {
          owocr = prev.owocr.overridePythonAttrs (old: {
            propagatedBuildInputs =
              (old.propagatedBuildInputs or [])
              ++ [
                prev.gst_all_1.gstreamer
                prev.gst_all_1.gst-plugins-base
                prev.gst_all_1.gst-plugins-good
                prev.gst_all_1.gst-plugins-bad
                prev.gobject-introspection
                prev.pipewire
                prev.wl-clipboard
              ];

            postFixup = ''
              wrapProgram "$out/bin/owocr" \
                --prefix GI_TYPELIB_PATH : "${prev.gst_all_1.gstreamer.out}/lib/girepository-1.0:${prev.gst_all_1.gst-plugins-base.out}/lib/girepository-1.0" \
                --prefix GST_PLUGIN_PATH : "${prev.pipewire}/lib/gstreamer-1.0:${prev.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${prev.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${prev.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0" \
                --prefix PATH : "${prev.wl-clipboard}/bin"
            '';
          });
        })
      ];
    };

    homeManager = {pkgs, ...}: let
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
          pkgs.perl
          pkgs.grim
          pkgs.slurp
          pkgs.kdePackages.spectacle
        ];
        text = ''
          set -euo pipefail

          CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/ocr"
          mkdir -p "$CACHE_DIR"
          TEMP_IMG="$CACHE_DIR/screenshot.png"
          TEMP_JSON="$CACHE_DIR/result.json"

          if [ "''${XDG_CURRENT_DESKTOP:-}" = "KDE" ] && command -v spectacle >/dev/null 2>&1; then
            if ! spectacle --region --background --nonotify --output "$TEMP_IMG"; then
              echo "Скриншот отменен" >&2
              exit 1
            fi
          elif command -v grim >/dev/null 2>&1 && command -v slurp >/dev/null 2>&1; then
            if ! grim -g "$(slurp)" "$TEMP_IMG"; then
              echo "Скриншот отменен" >&2
              exit 1
            fi
          elif command -v flameshot >/dev/null 2>&1; then
            if ! flameshot gui --path "$TEMP_IMG" 2>/dev/null; then
              echo "Скриншот отменен" >&2
              exit 1
            fi
          else
            echo "Нет доступного инструмента для скриншотов" >&2
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

          text=$(printf '%s' "$text" | perl -CSDA -pe 's/[\p{Z}\s\x{200B}\x{200C}\x{200D}\x{2060}\x{FEFF}]+//g')

          echo -n "$text" | wl-copy
          echo "$text"

          if command -v websocat >/dev/null 2>&1; then
            printf '%s' "$text" | timeout 2s websocat -1 -t ws://127.0.0.1:6677 >/dev/null 2>&1 || true
          fi

          if command -v notify-send >/dev/null 2>&1; then
            chars="''${#text}"
            preview=$(echo "$text" | cut -c1-50)
            sleep 0.2
            notify-send "OCR Готово" "Скопировано $chars символов: $preview..." 2>/dev/null || true
          fi

          rm -f "$TEMP_IMG" "$TEMP_JSON"
        '';
      };
    in {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
      ];

      home.packages = [
        nbocr
        ocr
        pkgs.owocr
      ];

      systemd.user.services.ocr-ws = {
        Unit = {
          Description = "OCR WebSocket broadcast server (ws://127.0.0.1:6677)";
          After = ["network.target"];
        };
        Service = {
          ExecStart = "${pkgs.websocat}/bin/websocat -t ws-l:127.0.0.1:6677 broadcast:mirror:";
          Restart = "always";
          RestartSec = 1;
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };

      programs.plasma = {
        shortcuts = {
          "services/net.local.ocr.desktop"._launch = "Meta+O";
        };
      };
    };
  };

  flake-file.inputs = {
    newbee-ocr.url = "github:kexan/newbee-ocr-cli-nix";
  };
}
