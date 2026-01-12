{
  perSystem =
    { pkgs, ... }:
    let
      update = pkgs.writeShellApplication {
        name = "update";
        runtimeInputs = [ pkgs.nix ];
        text = ''
          nix flake update
        '';
      };

      check = pkgs.writeShellApplication {
        name = "check";
        runtimeInputs = [ pkgs.nix ];
        text = ''
          nix flake check
        '';
      };

      build = pkgs.writeShellApplication {
        name = "build";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          HOSTNAME="''${1:-$(hostname)}"
          export NH_FLAKE="$PWD"
          nh os build -H "$HOSTNAME"
        '';
      };

      apply = pkgs.writeShellApplication {
        name = "apply";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          HOSTNAME="''${1:-$(hostname)}"
          export NH_FLAKE="$PWD"
          nh os switch -H "$HOSTNAME"
        '';
      };

      boot = pkgs.writeShellApplication {
        name = "boot";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          HOSTNAME="''${1:-$(hostname)}"
          export NH_FLAKE="$PWD"
          nh os boot -H "$HOSTNAME"
        '';
      };

      sops = pkgs.writeShellApplication {
        name = "sops";
        runtimeInputs = [ pkgs.sops ];
        text = ''
          sudo SOPS_AGE_KEY_FILE=/var/lib/sops-nix/key.txt EDITOR="$EDITOR" HOME="$HOME" XDG_CONFIG_HOME="$HOME/.config" sops "$@"
        '';
      };

      modules = pkgs.writeShellApplication {
        name = "modules";
        runtimeInputs = [
          pkgs.nix
          pkgs.jq
        ];
        text = ''
          ROOT_PATH="$PWD"

          EXPR="
            let
              flake = builtins.getFlake \"$ROOT_PATH\";
              
              isPublic = name: 
                let 
                   firstChar = builtins.substring 0 1 name;
                   isPrivate = firstChar == \"_\";
                   isHost = (builtins.match \"^hosts.*\" name) != null;
                in 
                   !(isPrivate || isHost);

              getPublicModules = set: 
                if builtins.isAttrs set 
                then builtins.filter isPublic (builtins.attrNames set)
                else [];
                
              nixos = getPublicModules (flake.modules.nixos or {});
              home = getPublicModules (flake.modules.homeManager or {});
            in
            {
              nixos = nixos;
              home = home;
            }
          "

          JSON=$(nix eval --json --impure --expr "$EXPR")

          echo ""

          SHARED=$(echo "$JSON" | jq -r '(.nixos // []) as $n | (.home // []) as $h | ($n - ($n - $h))[]' | sort)

          if [ -n "$SHARED" ]; then
            echo -e "\033[1;33m Shared Modules (Has both NixOS + Home Manager):\033[0m"
            echo "$SHARED" | while read -r module; do
                echo "  • $module"
            done
            echo ""
          fi

          NIXOS_ONLY=$(echo "$JSON" | jq -r '(.nixos // []) - (.home // []) | .[]' | sort)

          if [ -n "$NIXOS_ONLY" ]; then
            echo -e "\033[1;34m NixOS Only:\033[0m"
            echo "$NIXOS_ONLY" | while read -r module; do
                echo "  • $module"
            done
            echo ""
          fi

          HOME_ONLY=$(echo "$JSON" | jq -r '(.home // []) - (.nixos // []) | .[]' | sort)

          if [ -n "$HOME_ONLY" ]; then
            echo -e "\033[1;35m Home Manager Only:\033[0m"
            echo "$HOME_ONLY" | while read -r module; do
                echo "  • $module"
            done
            echo ""
          fi
        '';
      };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.nh
          update
          check
          build
          apply
          boot
          sops
          modules
        ];

        shellHook = ''
          HOSTNAME=$(hostname)

          echo -e "\033[1;34m╭────────────────────────────────────────────╮"
          echo -e "│  Nix Development Shell                     │"
          printf "│  Current host: %-27s │\n" "$HOSTNAME"
          echo -e "╰────────────────────────────────────────────╯\033[0m"
          echo ""
          echo -e "\033[1;35mAvailable commands:\033[0m"
          echo -e "  \033[1;36mupdate\033[0m           — nix flake update"
          echo -e "  \033[1;36mcheck\033[0m            — nix flake check"
          echo -e "  \033[1;36mbuild\033[0m [host]     — build configuration"
          echo -e "  \033[1;36mapply\033[0m [host]     — apply configuration"
          echo -e "  \033[1;36mboot\033[0m  [host]     — set boot configuration"
          echo -e "  \033[1;36msops\033[0m  <file>     — edit secrets (sops secrets/secrets.yaml)"
          echo -e "  \033[1;36mmodules\033[0m          — list available modules"
          echo ""
          echo -e "\033[2m(hostname is optional, defaults to current host)\033[0m"
        '';
      };
    };
}
