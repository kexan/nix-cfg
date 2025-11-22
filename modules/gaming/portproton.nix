{
  flake.modules = {
    nixos.gaming = {
      services.flatpak = {
        packages = [
          "ru.linux_gaming.PortProton"
        ];
      };
    };
  };
}
