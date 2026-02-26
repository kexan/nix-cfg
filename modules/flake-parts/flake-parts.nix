{
  lib,
  inputs,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.modules];

  options.flake.meta = lib.mkOption {
    type = with lib.types; lazyAttrsOf anything;
  };
}
