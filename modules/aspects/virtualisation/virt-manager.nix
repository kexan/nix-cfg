{
  den.aspects.virtualisation.provides.virt-manager = {
    nixos = {pkgs, ...}: {
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
      environment.systemPackages = with pkgs; [dnsmasq];
      networking.firewall.trustedInterfaces = ["virbr0"];
    };

    user = {
      extraGroups = ["libvirtd" "kvm"];
    };
  };
}
