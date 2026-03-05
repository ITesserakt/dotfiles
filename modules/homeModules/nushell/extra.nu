$env.config = {
  show_banner: false,
     
	completions: {
		case_sensitive: false,
		quick: true,
		# partial: false,
		# algorithm: "fuzzy",
		external: {
			enable: true,
			max_results: 25,
			completer: $external_completer
		}
	}
}

$env.PATH ++= ["~/.cargo/bin", "~/.local/bin"];
