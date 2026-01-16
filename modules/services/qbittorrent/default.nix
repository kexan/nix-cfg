{
  flake.modules.nixos.qbittorrent =
    {
      lib,
      config,
      pkgs,
      ...
    }:

    let
      caddyEnabled = config.services.caddy.enable or false;
      sambaEnabled = config.services.samba.enable or false;

      localDomain = "torrent.lan";
      tPort = 50000;
      wPort = 8080;
    in
    {
      services = {
        qbittorrent = {
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
        };

        caddy = lib.mkIf caddyEnabled {
          virtualHosts."http://${localDomain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:${toString wPort}
            '';
          };
        };

        samba = lib.mkIf sambaEnabled {
          settings = {
            torrents = {
              browseable = "yes";
              comment = "qBittorrent read-only";
              "guest ok" = "yes";
              path = "/var/lib/qBittorrent/qBittorrent/downloads";
              "read only" = "yes";
            };
          };
        };
      };

      networking.firewall = {
        allowedTCPPorts = [ tPort ] ++ lib.optionals (!caddyEnabled) [ wPort ];
        allowedUDPPorts = [ tPort ];
      };
    };
}
