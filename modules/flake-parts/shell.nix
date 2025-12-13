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

      build = pkgs.writeShellApplication {
        name = "build";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          if [ $# -eq 0 ]; then
            echo "Usage: build <hostname>" >&2
            exit 1
          fi

          export NH_FLAKE="$PWD"
          nh os build -H "$1"
        '';
      };

      apply = pkgs.writeShellApplication {
        name = "apply";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          if [ $# -eq 0 ]; then
            echo "Usage: apply <hostname>" >&2
            exit 1
          fi

          export NH_FLAKE="$PWD"
          nh os switch -H "$1"
        '';
      };

      boot = pkgs.writeShellApplication {
        name = "boot";
        runtimeInputs = [ pkgs.nh ];
        text = ''
          if [ $# -eq 0 ]; then
            echo "Usage: boot <hostname>" >&2
            exit 1
          fi

          export NH_FLAKE="$PWD"
          nh os boot -H "$1"
        '';
      };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.nh
          update
          build
          apply
          boot
        ];

        shellHook = ''
          echo "Nix shell ready"
          echo "update            — nix flake update"
          echo "build <hostname>  — nh os build -H <hostname>"
          echo "apply <hostname>  — nh os switch -H <hostname>"
          echo "boot  <hostname>  — nh os boot  -H <hostname>"
        '';
      };
    };
}
