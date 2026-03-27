{
  den,
  inputs,
  ...
}: {
  den.aspects.desktop.provides.plasma = {
    includes = [
      den.aspects.desktop.provides.fonts
    ];

    nixos = {pkgs, ...}: {
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.plasma-login-manager.enable = true;
      };

      security.pam.services.plasma-login-manager = {
        enableKwallet = true;
        fprintAuth = false;
      };

      programs.ssh = {
        startAgent = true;
        enableAskPassword = true;
        askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      };

      environment = {
        plasma6.excludePackages = [pkgs.kdePackages.elisa];

        systemPackages = [
          pkgs.kdePackages.ksshaskpass
          (pkgs.runCommand "breeze-cursor-fix" {} ''
            mkdir -p $out/share/icons
            ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
          '')
        ];

        sessionVariables = {
          SSH_ASKPASS_REQUIRE = "prefer";
        };
      };

      xdg.portal = {
        enable = true;
        config = {
          kde = {
            default = [
              "kde"
              "gtk"
              "gnome"
            ];
            "org.freedesktop.portal.FileChooser" = ["kde"];
            "org.freedesktop.portal.OpenURI" = ["kde"];
          };
        };
        extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
      };
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
      ];

      home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";

      programs.plasma.enable = true;

      home.packages = with pkgs; [
        kdePackages.kate
        kdePackages.krdc
        haruna
      ];
    };
  };

  flake-file.inputs = {
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
