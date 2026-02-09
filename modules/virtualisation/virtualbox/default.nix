{
  flake.modules = {
    nixos.virtualbox = {
      virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };

      boot.blacklistedKernelModules = [
        "kvm_amd"
        "kvm_intel"
        "kvm"
      ];
    };
  };
}
