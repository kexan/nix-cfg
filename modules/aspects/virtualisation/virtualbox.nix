{
  den.aspects.virtualisation.provides.virtualbox = {
    nixos = {
      virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };
      boot.blacklistedKernelModules = ["kvm_amd" "kvm_intel" "kvm"];
    };

    user = {
      extraGroups = ["vboxusers"];
    };
  };
}