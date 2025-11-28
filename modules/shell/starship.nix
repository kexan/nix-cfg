{
  flake.modules = {
    homeManager.shell = {
      programs = {
        starship = {
          enable = true;
          enableTransience = true;
        };
      };
    };
  };
}
