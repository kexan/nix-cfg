{
  flake.modules.nixos.samba = {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "server min protocol" = "SMB2_02";
          "netbios name" = "nix-samba";
          "server string" = "NixOS Samba Server";

          "vfs objects" = "catia fruit streams_xattr";
          "fruit:metadata" = "stream";
          "fruit:model" = "MacSamba";
          "fruit:nfs_aces" = "no";
          "fruit:posix_rename" = "yes";
          "fruit:veto_appledouble" = "no";
          "fruit:wipe_intentionally_left_blank_rfork" = "yes";
          "fruit:delete_empty_adfiles" = "yes";

          "map to guest" = "Bad User";
        };
      };
    };
  };
}
