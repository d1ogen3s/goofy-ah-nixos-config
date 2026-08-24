{ ... }:

{
	virtualisation.docker.enable = true;

	users.users.johndoe.extraGroups = [ "docker" ];
}
