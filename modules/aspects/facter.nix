{
  den.aspects.facter = facterReportPath: {
    nixos = {
      hardware.facter.detected.dhcp.enable = false;
      hardware.facter.reportPath = facterReportPath;
    };
  };
}
