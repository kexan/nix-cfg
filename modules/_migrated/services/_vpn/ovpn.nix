{inputs, ...}: {
  flake.modules = {
    nixos.vpn = {
      lib,
      config,
      pkgs,
      ...
    }: let
      sopsEnabled = config.sops.enable or false;
    in {
      imports = [inputs.sops-nix.nixosModules.sops];

      networking.networkmanager.plugins = [pkgs.networkmanager-openvpn];

      sops = lib.mkIf sopsEnabled {
        secrets = {
          "vpn/internal/ca" = {};
          "vpn/internal/cert" = {};
          "vpn/internal/key" = {};
          "vpn/internal/tls-crypt" = {};

          "vpn/kz/ca" = {};
          "vpn/kz/cert" = {};
          "vpn/kz/key" = {};
          "vpn/kz/tls-crypt" = {};
        };
      };

      networking.networkmanager.ensureProfiles.profiles = lib.mkIf sopsEnabled {
        "internal-s.nikitin" = {
          connection = {
            id = "internal-s.nikitin";
            uuid = "0a244822-0225-4e90-bba4-612554922667";
            type = "vpn";
            permissions = "";
          };
          vpn = {
            service-type = "org.freedesktop.NetworkManager.openvpn";
            connection-type = "tls";
            dev = "tun";
            auth = "SHA512";
            cipher = "AES-256-GCM";
            "challenge-response-flags" = "2";
            remote = "91.219.191.187:1194:udp, 77.244.220.235:1194:udp";
            "remote-random" = "yes";
            "remote-cert-tls" = "server";
            ping = "10";
            "ping-restart" = "6";

            ca = config.sops.secrets."vpn/internal/ca".path;
            cert = config.sops.secrets."vpn/internal/cert".path;
            key = config.sops.secrets."vpn/internal/key".path;
            "tls-crypt" = config.sops.secrets."vpn/internal/tls-crypt".path;
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            method = "auto";
            "addr-gen-mode" = "default";
          };
        };

        "s.nikitin-kz" = {
          connection = {
            id = "s.nikitin-kz";
            uuid = "8190c127-2874-4f21-8566-6e72c551a370";
            type = "vpn";
            permissions = "";
          };
          vpn = {
            service-type = "org.freedesktop.NetworkManager.openvpn";
            connection-type = "tls";
            dev = "tun";
            auth = "SHA512";
            cipher = "AES-256-GCM";
            "challenge-response-flags" = "2";
            remote = "88.218.70.110:1194:udp";
            "remote-cert-tls" = "server";

            ca = config.sops.secrets."vpn/kz/ca".path;
            cert = config.sops.secrets."vpn/kz/cert".path;
            key = config.sops.secrets."vpn/kz/key".path;
            "tls-crypt" = config.sops.secrets."vpn/kz/tls-crypt".path;
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            method = "auto";
            "addr-gen-mode" = "default";
          };
        };
      };
    };
  };
}
