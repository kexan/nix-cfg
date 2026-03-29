{
  den,
  __findFile,
  ...
}: {
  den.aspects.virtualisation.provides.virtualbox = {
    includes = [
      (den.provides.unfree [
        "virtualbox-extpack"
      ])
      (<tools/groups> ["vboxusers"])
    ];

    nixos = {
      virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };
      boot.blacklistedKernelModules = ["kvm_amd" "kvm_intel" "kvm"];
    };
  };
}
