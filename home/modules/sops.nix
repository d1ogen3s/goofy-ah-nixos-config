{ config, ... }:

{
	sops = {
		defaultSopsFile = ../../secrets/secrets.json;
		
		age.keyFile = "/home/johndoe/.config/sops/age/keys.txt";


	};

	sops.secrets = {
		"ai_keys/GEMINI_API_KEY" = {};
		"ai_keys/OPENROUTER_API_KEY" = {};
	};

	sops.templates."ai_keys.env".content = ''
		export GEMINI_API_KEY="${config.sops.placeholder."ai_keys/GEMINI_API_KEY"}"
		export OPENROUTER_API_KEY="${config.sops.placeholder."ai_keys/OPENROUTER_API_KEY"}"
	'';

	programs.bash.initExtra = ''
		if [ -f "${config.sops.templates."ai_keys.env".path}" ]; then
			source "${config.sops.templates."ai_keys.env".path}"
		fi
	'';
}
