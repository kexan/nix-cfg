{ inputs, ... }:
{
  flake.modules = {
    nixos.plasma =
      { pkgs, ... }:

      let
        # Фикс маленького курсора в некоторых приложениях
        breezeCursorDefaultTheme = pkgs.runCommandLocal "breeze-cursor-default-theme" { } ''
          mkdir -p $out/share/icons
          ln -s ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors $out/share/icons/default
        '';
      in
      {
        services = {
          desktopManager.plasma6.enable = true;
          power-profiles-daemon.enable = true;
        };

        programs.ssh = {
          startAgent = true;
          enableAskPassword = true;
          askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
        };

        environment = {
          plasma6.excludePackages = [ pkgs.kdePackages.elisa ];

          systemPackages = [
            pkgs.kdePackages.ksshaskpass
            breezeCursorDefaultTheme
          ];

          sessionVariables = {
            SSH_ASKPASS_REQUIRE = "prefer";
          };
        };

        xdg = {
          autostart.enable = true;

          portal = {
            enable = true;
            config.common.default = "kde";
            extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
          };
        };

        home-manager.sharedModules = [
          inputs.self.modules.homeManager.plasma
        ];
      };

    homeManager.plasma =
      { pkgs, ... }:

      {
        imports = [
          inputs.plasma-manager.homeModules.plasma-manager
        ];

        programs.plasma.enable = true;

        xdg.autostart.enable = true;

        home.packages = with pkgs; [
          kdePackages.kate
          kdePackages.krdc
          haruna
        ];

        home.file.".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";
      };
  };
}
