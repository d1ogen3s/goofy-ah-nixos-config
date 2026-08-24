{ config, pkgs, ... }:

{
	virtualisation.podman.enable = true; 
	virtualisation.oci-containers.backend = "podman"; 

	virtualisation.oci-containers.containers.omniroute = {
		image = "diegosouzapw/omniroute:latest";
		autoStart = true;
		ports = [ 
			"20128:20128" 
		];
		volumes = [ 
			"/var/lib/omniroute-data:/app/data" 
		];
		environment = {

		};

		extraOptions = [ "--stop-timeout=40" ];
	};
}
