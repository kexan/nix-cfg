{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  #TODO: описать конфиг zen
  programs.zen-browser.enable = true;
}
