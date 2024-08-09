let
  gpuIDs = [
    #"1002:1638"
    #"1002:1637"
    "1002:73df"
    "1002:ab28"
  ];
in
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";

  config =
    let
      cfg = config.vfio;
    in
    {
      boot = {
        #initrd.kernelModules = [
        kernelModules = [
          "kvm-amd"
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          "amdgpu"
        ];
        kernelParams = [
          # enable IOMMU
          "iommu=pt"
          "amd_iommu=on"
          "kvm.ignore_msrs=1"
          "pcie_acs_override=downstream,multifunction"
        ];
        extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," gpuIDs}";
      };

      hardware.opengl.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };
}
