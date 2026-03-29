{
  den,
  lib,
  ...
}: {
  den.aspects.tools.provides.groups = groups:
    den.lib.parametric {
      includes = [
        ({user, ...}: {
          nixos.users.users.${user.userName}.extraGroups = lib.flatten [groups];
        })
      ];
    };
}
