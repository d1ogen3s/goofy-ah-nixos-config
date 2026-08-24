{
	description = "No snow flake can be copied. Except for this one.";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser = {
			url = "github:youwen5/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		openclaw-nix = {
			url = "github:openclaw/nix-openclaw";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
	let 
		create_host = hostname: nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./common.nix
				./hosts/${hostname}/configuration.nix

				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.johndoe = import ./home/home.nix;
						backupFileExtension = "backup";
						extraSpecialArgs = {
							flakePath = "/home/johndoe/.nixos-config";
							inherit inputs;
						};
					};
				}
			];
		};

	in {
		nixosConfigurations = {
			obr = create_host "obr";
			prcek = create_host "prcek";
		};
	};
}
