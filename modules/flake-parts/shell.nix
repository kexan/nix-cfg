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
          echo ""
          echo -e "\033[2m(hostname is optional, defaults to current host)\033[0m"
        '';
      };
    };
}
