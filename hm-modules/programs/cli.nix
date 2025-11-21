{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qwen-code
  ];

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    fd.enable = true;
    ripgrep.enable = true;
    lazydocker.enable = true;
  };
}
