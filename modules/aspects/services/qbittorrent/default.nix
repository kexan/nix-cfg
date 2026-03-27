{
  den.aspects.services.provides.qbittorrent = {
    nixos = {pkgs, ...}: {
      services = {
        qbittorrent = {
          enable = true;
          torrentingPort = 50000;
          webuiPort = 8080;
          openFirewall = true;

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
              Session = {
                AlternativeGlobalDLSpeedLimit = 6000;
                AlternativeGlobalUPSpeedLimit = 6000;
                DisableAutoTMMByDefault = false;
              };
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

        caddy.virtualHosts."http://torrent.lan" = {
          extraConfig = ''
            reverse_proxy 127.0.0.1:8080
          '';
        };
      };
    };
  };
}
