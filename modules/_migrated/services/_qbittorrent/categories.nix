{
  flake.modules.nixos.qbittorrent = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.services.qbittorrent;
    categoriesJson = builtins.toJSON (lib.mapAttrs (name: path: {save_path = path;}) cfg.categories);
    categoriesFile = pkgs.writeText "categories.json" categoriesJson;
    configPath = "${cfg.profileDir}/qBittorrent/config";
  in {
    options.services.qbittorrent = {
      categories = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = "Map of category names to their save paths (relative or absolute).";
        example = {
          "Игры" = "games";
          "Фильмы" = "/mnt/share/movies";
        };
      };
    };

    config = lib.mkIf (cfg.enable && cfg.categories != {}) {
      systemd.services.qbittorrent.preStart = lib.mkAfter ''
        mkdir -p '${configPath}'
        cp -f '${categoriesFile}' '${configPath}/categories.json'
        chmod 640 '${configPath}/categories.json'
        chown ${cfg.user}:${cfg.group} '${configPath}/categories.json'
      '';
    };
  };
}
