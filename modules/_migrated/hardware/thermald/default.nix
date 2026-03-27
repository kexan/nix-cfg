{
  flake.modules.nixos.thermald = {
    nixpkgs.overlays = [
      (final: prev: {
        thermald = prev.thermald.overrideAttrs (old: {
          version = "2.5.11";

          src = prev.fetchFromGitHub {
            owner = "intel";
            repo = "thermal_daemon";
            rev = "v2.5.11";
            sha256 = "sha256-IHBfNqiMd2q5vj+xpo31LFy19zwv0GkB0GoHq8Ni7aA=";
          };
        });
      })
    ];

    services.thermald = {
      enable = true;
    };
  };
}
