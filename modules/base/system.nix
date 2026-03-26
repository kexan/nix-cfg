let
  stateVersion = "25.05";
in {
  den.aspects.base = {
    homeManager = {
      home = {
        inherit stateVersion;
      };
    };

    nixos = {
      system = {
        inherit stateVersion;
      };
    };
  };
}
