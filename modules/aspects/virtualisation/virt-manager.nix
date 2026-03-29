{__findFile, ...}: {
  den.aspects.virtualisation.provides.virt-manager = {
    includes = [
      (<tools/groups> ["libvirtd" "kvm"])
    ];

    nixos = {pkgs, ...}: {
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
      environment.systemPackages = with pkgs; [dnsmasq];
      networking.firewall.trustedInterfaces = ["virbr0"];
    };
  };
}
