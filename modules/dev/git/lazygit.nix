{
  flake.modules = {
    homeManager.dev = {
      programs = {
        lazygit = {
          enable = true;
        };
      };
    };
  };
}
