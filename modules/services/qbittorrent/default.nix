{
  flake.modules.nixos.qbittorrent =
    {
      lib,
      config,
      pkgs,
      ...
    }:

    let
      localDomain = "torrent.lan";
      caddyEnabled = config.services.caddy.enable or false;
      tPort = 50000;
      wPort = 8080;
    in
    {
      config = {
        services.qbittorrent = lib.mkMerge [
          {
            enable = true;
            torrentingPort = tPort;
            webuiPort = wPort;

            categories = {
              "Игры" = "games";
              "Сериалы" = "shows";
              "Фильмы" = "movies";
            };

            serverConfig = {
              Network = {
                PortForwardingEnabled = false;
              };
              BitTorrent = {
                Session.DisableAutoTMMByDefault = false;
              };
              Preferences = {
                General.Locale = "ru";
                WebUI = {
                  AlternativeUIEnabled = true;
                  RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";

                  AuthSubnetWhitelistEnabled = true;
                  AuthSubnetWhitelist = "192.168.10.0/24";
                  LocalHostAuth = false;
                };
              };
            };
          }
        ];

        networking.firewall = {
          allowedTCPPorts = [ tPort ] ++ lib.optionals (!caddyEnabled) [ wPort ];
          allowedUDPPorts = [ tPort ];
        };

        services.caddy = lib.mkIf caddyEnabled {
          virtualHosts."http://${localDomain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:${toString wPort}
            '';
          };
        };
      };
    };
}
