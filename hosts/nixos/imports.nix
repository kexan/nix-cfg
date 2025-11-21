{
  imports = [
    # Gaming modules
    ../../modules/gaming/steam.nix

    # Package modules
    ../../modules/packages/flatpak.nix
    ../../modules/packages/pkgs.nix

    # Program modules
    ../../modules/programs/corectrl.nix
    ../../modules/programs/docker.nix
    ../../modules/programs/plasma.nix
    ../../modules/programs/throne.nix
    ../../modules/programs/virtualbox.nix

    # System modules
    ../../modules/system/bootloader.nix
    ../../modules/system/display-manager.nix
    ../../modules/system/fonts.nix
    ../../modules/system/locale.nix
    ../../modules/system/network.nix
    ../../modules/system/nix.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/shell.nix
  ];
}
