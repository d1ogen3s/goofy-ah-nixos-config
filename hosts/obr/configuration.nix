{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	networking.hostName = "obr";

	environment.shellAliases = {
		nrs = "git -C ~/.nixos-config/ add . && sudo nixos-rebuild switch --flake ~/.nixos-config#obr";
	};

	environment.systemPackages = with pkgs; [
		nvtopPackages.nvidia
		libsmbios
	];

	boot.kernelModules = [ "dell-smm-hwmon" ];
	
	boot.extraModprobeConfig = ''
		options dell-smm-hwmon restricted=0 force=1 ignore_dmi=1
	'';

	services.xserver.videoDrivers = ["nvidia"];


	environment.sessionVariables = {
		LIBVA_DRIVER_NAME = "nvidia";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		NIXOS_OZONE_WL = "1";
	};

	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = true;
		open = true;
		nvidiaSettings = true;

		prime = {
			sync.enable = true;
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	};
}
