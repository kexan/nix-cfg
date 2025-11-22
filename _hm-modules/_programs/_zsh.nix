{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = false;
      antidote = {
        enable = true;
        plugins = [
          "marlonrichert/zsh-autocomplete"
        ];
      };
      initContent = ''
        export EDITOR=nvim
        alias cd='z'
      '';
    };

    oh-my-posh = {
      enable = true;
      useTheme = "1_shell";
    };
  };
}
