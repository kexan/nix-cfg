{inputs, ...}: {
  flake.modules = {
    nixos.plasma = {pkgs, ...}: {
      services = {
        desktopManager.plasma6.enable = true;
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

      xdg = {
        autostart.enable = true;

        portal = {
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

      home-manager.sharedModules = [
        inputs.self.modules.homeManager.plasma
      ];
    };

    homeManager.plasma = {pkgs, ...}: {
      imports = [
        inputs.plasma-manager.homeModules.plasma-manager
      ];

      home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";

      programs.plasma.enable = true;

      xdg.autostart.enable = true;

      home.packages = with pkgs; [
        kdePackages.kate
        kdePackages.krdc
        haruna
      ];
    };
  };
}
