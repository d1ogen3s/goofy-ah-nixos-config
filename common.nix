{ config, lib, pkgs, inputs, ... }:

{
	imports = [
		./modules/sddm/configuration.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Prague";

	services.printing.enable = true;

	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	services.libinput.enable = true;

	users.users.johndoe = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		packages = with pkgs; [ ];
	};
	
	environment.systemPackages = with pkgs; [
		vim
		wget
		git
		neovim
		librewolf
		kitty
		tmux
		gh
		waybar
		rofi
		awww
		fzf

		inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	];

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
		withUWSM = false;
	};
	
	services.xserver.enable = true;

	services.displayManager.defaultSession = "hyprland";

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	hardware.graphics.enable = true;

	system.stateVersion = "26.05"; 
}

