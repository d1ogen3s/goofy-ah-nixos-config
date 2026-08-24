{ pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		sideloadInitLua = true;
		plugins = with pkgs.vimPlugins; [
			lazy-nvim
		];
	};
}
