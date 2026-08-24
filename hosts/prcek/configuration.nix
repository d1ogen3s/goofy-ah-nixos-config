{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	networking.hostName = "prcek";
	environment.shellAliases = {
		nrs = "git -C ~/.nixos-config/ add . && sudo nixos-rebuild switch --flake ~/.nixos-config#prcek";
	};

	environment.systemPackages = with pkgs; [
		nvtopPackages.amd
	];

	services.xserver.videoDrivers = ["amdgpu"];

	networking.networkmanager.wifi.macAddress = "preserve";

	hardware.enableRedistributableFirmware = true;
	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [

	];
}
