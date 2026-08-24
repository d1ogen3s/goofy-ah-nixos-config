{ config, lib, pkgs, inputs, ... }:

let
	here-is-my-sddm-theme = pkgs.where-is-my-sddm-theme.override {
		themeConfig.General = {
			passwordcharacter="∗";
			backgroundFill="#1e1e2e";
			basicTextColor="#cdd6f4";
			passwordCursorColor="#cdd6f4";
			passwordInputBackground="#1e1e2e";
			passwordTextColor="#cdd6f4";
		};
	};

in {
	environment.systemPackages = with pkgs; [
		here-is-my-sddm-theme
	];

	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;

		theme = "where_is_my_sddm_theme";
		extraPackages = with pkgs; [
			here-is-my-sddm-theme
			kdePackages.qt5compat
			kdePackages.qtsvg
		];
	};
}
