{ config, pkgs, ... }:

{
	programs.git.enable = true;
	programs.bash = { enable = true; };

	xdg.configFile."hypr/hyprland.lua".source = ./modules/hyprland/hyprland.lua;

	home = {
		username = "johndoe";
		homeDirectory = "/home/johndoe";
		stateVersion = "26.05";

		pointerCursor = {
			enable = true;
			name = "Bibata-Modern-Classic"; # Replace with your exact cursor theme name
			package = pkgs.bibata-cursors; # Replace with the corresponding nixpkgs package
			size = 24;
			gtk.enable = true;
			x11.enable = true;
		};
	};
}
