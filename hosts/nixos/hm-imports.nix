{
  imports = [
    # Pkgs module
    ../../hm-modules/packages/pkgs.nix

    # Program modules
    ../../hm-modules/programs/cli.nix
    ../../hm-modules/programs/communication.nix
    ../../hm-modules/programs/git.nix
    ../../hm-modules/programs/lazyvim.nix
    ../../hm-modules/programs/zen-browser.nix
    ../../hm-modules/programs/zsh.nix

    # Theme modules
    ../../hm-modules/themes
  ];
}
