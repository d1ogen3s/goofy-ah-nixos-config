{ config, pkgs, inputs, flakePath, ... }:

let
	configsPath = "${flakePath}/home/configs";
	homePath = "${flakePath}/home";
in
{
	imports = [
		./modules/nvim.nix
		./modules/sops.nix
		./modules/aider.nix
		./modules/fzf.nix
		./modules/gh.nix

		inputs.sops-nix.homeManagerModules.sops
	];

	programs.git.enable = true;
	programs.bash.enable = true;

	home.file.".scripts".source = config.lib.file.mkOutOfStoreSymlink "${homePath}/scripts";

	xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/hypr";
	xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/tmux";
	xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/kitty";
	xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/waybar";
	xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/nvim";
	xdg.configFile."rofi".source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/rofi";

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
