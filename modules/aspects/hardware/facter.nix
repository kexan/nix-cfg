{
  den.aspects.hardware.provides.facter = facterReportPath: {
    nixos = {
      hardware.facter.detected.dhcp.enable = false;
      hardware.facter.reportPath = facterReportPath;
    };
  };
}
