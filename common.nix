{ config, lib, pkgs, inputs, ... }:

{
	imports = [
		./modules/sddm.nix
		./modules/docker.nix
		#./modules/omniroute.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;

	networking.networkmanager.enable = true;
#	networking.wireless.iwd.enable = true;
#	networking.networkmanager.wifi.backend = "iwd";

	services.resolved.enable = true;

	time.timeZone = "Europe/Prague";

	services.printing.enable = true;

	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	services.libinput.enable = true;

	swapDevices = [{
		device = "/swapfile";
		size = 16 * 1024; # 16GB
	}];

	users.users.johndoe = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		packages = with pkgs; [ ];
	};

	environment.sessionVariables = {
		AQ_DRM_DEVICES = "/dev/dri/card2:/dev/dri/card1";
	};

	programs.ssh.enableAskPassword = false;

	services.thermald.enable = true;
	services.power-profiles-daemon.enable = false;

	services.gvfs.enable = true;

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		discord-canary
		yazi
		android-file-transfer
		kdePackages.dolphin
		kdePackages.kio-extras
		bc
		libreoffice
		fastfetch
		lm_sensors
		hyprshot
		vim
		wget
		git
		kitty
		tmux
		waybar
		awww
		fzf
		rofi
		bzmenu
		iwmenu
		iwd
		brightnessctl
		sops
		aider-chat
		unzip
		nodejs_26
		docker-compose
		firefox
		localsend

		gcc

		inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
	];



	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

	programs.hyprland = {
		enable = true;
		withUWSM = true;
		xwayland.enable = true;
	};

	services.displayManager.defaultSession = "hyprland";

	services.xserver.enable = true;

	programs.nix-ld.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.settings.auto-optimise-store = true;

	hardware.graphics.enable = true;

	system.stateVersion = "26.05"; 
}

