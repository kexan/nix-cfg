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
            in
            {
              nixos = getPublicModules (flake.modules.nixos or {});
              home = getPublicModules (flake.modules.homeManager or {});
            }
          "

          JSON=$(nix eval --json --impure --expr "$EXPR")

          echo ""
          echo -e "\033[1;34m NixOS Modules:\033[0m"
          echo "$JSON" | jq -r '(.nixos // [])[]' | sort | while read -r module; do
              echo "  • $module"
          done

          echo ""
          echo -e "\033[1;35m Home Manager Modules:\033[0m"
          echo "$JSON" | jq -r '(.home // [])[]' | sort | while read -r module; do
              echo "  • $module"
          done
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
