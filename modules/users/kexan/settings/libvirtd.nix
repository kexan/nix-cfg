{
  flake.modules.nixos.kexan = {
    lib,
    config,
    ...
  }: let
    libvirtdEnabled = config.virtualisation.libvirtd.enable or false;
  in {
    users.users.kexan.extraGroups = lib.mkIf libvirtdEnabled ["libvirtd"];
  };
}
