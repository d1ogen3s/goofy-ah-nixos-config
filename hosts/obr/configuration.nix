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
	];

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"nvidia-x11"
		"cuda_nvml_dev"
		"nvidia-settings"
	];

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		modesetting.enable = true;
		open = true;
		nvidiaSettings = true;
	};
}
