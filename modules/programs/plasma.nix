{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.krdc
    haruna
  ];

  xdg.portal.extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
}
